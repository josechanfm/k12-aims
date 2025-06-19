<?php

use function JmesPath\search;
use Application\Libraries\Psr4\MyArrayToXml;
use kcfinder\session;
use Mpdf\Tag\Option;

defined('BASEPATH') or exit('No direct script access allowed');

class Export extends Admin_Controller
{
	public function __construct()
	{
		parent::__construct();

		$this->load->model('kid_conducts_scores_model', 'kid_conducts_scores');
		$this->load->model('conducts_model', 'conducts');
		$this->load->model('teacher_model', 'teacher');
		$this->load->model('years_model', 'years');
		$this->load->model('squads_model', 'squads');
		$this->load->model('kid_teachers_squads_model', 'kid_teachers_squads');
		$this->load->model('feedbacks_model', 'feedbacks');
		$this->load->model('kid_scores_model', 'kid_scores');
		$this->load->model('kid_topics_model', 'kid_topics');
		$this->load->model('scores_model', 'scores');
		$this->load->model('head_conducts_model', 'head_conducts');
		$this->load->model('subjects_model', 'subjects');
		$this->load->model('school_configs_model', 'school_configs');
		$this->load->model('squads_students_model', 'squads_students');
		$this->load->model('disciplines_model', 'disciplines');
		$this->load->model('school_configs_model', 'school_configs');
		$this->load->model('students_model', 'students');
		$this->load->model('merits_records_model', 'merits_records');
		$this->load->model('absents_merits_model', 'absents_merits');
		$this->load->model('grades_model', 'grades');
		$this->load->model('general_scores_model', 'general_scores');
		$this->load->model('admin_users_model', 'admin_users');
		$this->load->model('curriculums_model', 'curriculums');
		$this->load->model('extra_activities_model', 'extra_activities');
		session_write_close();
		ini_set("memory_limit", "-1");
		ini_set('max_execution_time', '0');
		// if (!$this->ion_auth->in_group([
		// 	'webmaster', 'manage', 'p_extra', 's_extra', 'extra', 'admin', 's_admin', 'p_admin', 'k_admin', 's_vice_principal', 'p_vice_principal', 'principal', 's_principal'
		// ])) {
		// 	redirect('');
		// }
	}

	function kid_score_import()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$this->kid_scores->export_students_scores($_POST);
	}

	function kid_head_class_import($type)
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$this->kid_teachers_squads->export_kid_head_class_excel($_POST, $type);
	}

	//export whole subject score excel 
	function whole_subject_score($subjectId)
	{
		$this->scores->whole_subject_score($subjectId);
	}


	//export the template to teacher in order to import easily
	function subject_student_list_template($type) // elective 有用   其他no use
	{

		if ($type == 'elective') {
			$_POST = json_decode(file_get_contents("php://input"), true);
			$file = 'assets/uploads/elective.xlsx';
			$this->load->library('my_spreadsheet');
			$this->my_spreadsheet->export_elective($file, $_POST);
		} else {
			if ($type == 'conduct') {
				$file = 'assets/uploads/squad_conduct.xlsx';
			} else if ($type == 'score') {
				$file = 'assets/uploads/squad_score.xlsx';
			}
			$_POST = json_decode(file_get_contents("php://input"), true);

			$squads_students = $this->db->select("ss.student_number, Concat(s.last_name, s.first_name) as name")->where('ss.active', 0)->where('ss.squad_id', $_POST['squadId'])->join("students as s", 's.id = ss.student_id', 'left')->order_by('ss.student_number', 'ASC')->get("squads_students as ss")->result();

			$subject = $this->subjects->get($_POST['subjectId']);
			$discipline = $this->disciplines->get($subject->discipline_id);
			$teacher = $this->db->select('concat(last_name, first_name) as name')->where('id', $subject->teacher_id)->get('admin_users')->row();
			$squad = $this->squads->get($_POST['squadId']);

			$data = array(
				"squad_name" => $squad->name,
				"subject_name" => $discipline->name,
				"teacher_name" => $teacher->name,
				"students" => $squads_students
			);

			$this->load->library('my_spreadsheet');
			$this->my_spreadsheet->export_squad_score($file, $squad->name . $discipline->name, $data);
		}
	}

	//export whole subject score excel 
	function squads_students_ranking($squad_id = false)
	{


		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_id = $_POST['squad_id'] ?? $squad_id;
		$this->load->model('pdf_model');
		$squad = $this->squads->get($squad_id);
		$data = $this->squads_students->squad_rank($squad_id); // 默認 final
		$data = array_map(function ($v) {
			unset($v['id']);
			unset($v['squad_id']);
			unset($v['squad_name']);
			unset($v['science_art']);
			return $v;
		}, $data);
		usort($data, function ($a, $b) {
			return $a['student_number'] - $b['student_number'];
		});
		$name = $squad->name . '排行榜';
		$file = 'assets/uploads/student_ranking.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_student_ranking($file, $data, $name);
	}


	function award_list($student_id)
	{

		$student = $this->students->get($student_id);
		$data = $this->db
			->select('mt.year_code, mt.name as match_name,m.remark, m.have_award')
			->where('m.student_id', $student_id)
			->order_by('mt.year_code', 'DESC')
			->join('match_types as mt', 'mt.id=m.match_type_id')
			->get('matchs as m')
			->result_array();

		foreach ($data as $key => $value) {
			$data[$key]['have_award'] = ($data[$key]['have_award'] == 1 ? '得獎' : '');
		}
		$name = $student->last_name . $student->first_name;
		$file = 'assets/uploads/student_award.xlsx';

		$this->load->library('my_spreadsheet');

		$this->my_spreadsheet->export_award($file, $data, $name);
	}


	//成績總表(分段數)(中學)(通用)
	public function grade_all_scores_excel()
	{
		ini_set("pcre.backtrack_limit", "10000000");
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_ids = $_POST['squad_ids'];
		$sem = $_POST['sem'];
		$is_pdf = $_POST['is_pdf'];
		if ($this->config->item('school') == 'CK') {
			$spreadsheet = 'assets/uploads/export_file/ck_all_scores.xlsx';
		} else {
			$spreadsheet = 'assets/uploads/export_file/san_all_scores.xlsx';
		}
		foreach ($squad_ids as $squad_id) {
			$spreadsheet = $this->_all_scores_excel($spreadsheet, $squad_id, $sem);
		}
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}

	public function all_scores_excel($squad_id=false)
	{	session_write_close();
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		//$_POST['is_pdf']=true; 	$_POST['sem'] =1;//delete
		$squad_id = $_POST['squad_id']??$squad_id;
		$sem = $_POST['sem']??2;
		$is_pdf = $_POST['is_pdf']??true;
		if ($this->config->item('school') == 'CK') {
			$spreadsheet = 'assets/uploads/export_file/ck_all_scores.xlsx';
		} else {
			//if school_type  == '2'
			$spreadsheet = 'assets/uploads/export_file/san_all_scores.xlsx';
		}

		$spreadsheet = $this->_all_scores_excel($spreadsheet, $squad_id, $sem);
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}

	function _all_scores_excel($file_or_sheet, $squad_id, $sem)
	{
		$this->load->library('export_summary_xlsx');
		$spreadsheet = $this->export_summary_xlsx->_all_scores_excel($this, $file_or_sheet, $squad_id, $sem);
		return $spreadsheet;
	}

	public function ck_formsix_final()
	{	$this->load->library('export_summary_xlsx');
		//只for ck
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_ids = $_POST['squad_ids'];
		$is_pdf = $_POST['is_pdf'];
		//$file = 'assets/uploads/export_file/ck_formsix_final.xlsx';
		$file = 'assets/uploads/export_file/ck_all_scores.xlsx';
		$spreadsheet = $file;
		foreach ($squad_ids as $squad_id) {
			$spreadsheet = $this->export_summary_xlsx->year_six_summary_ck($this, $spreadsheet, $squad_id);
			//$spreadsheet = $this->_ck_formsix_final($spreadsheet, $squad_id);
		}
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}

	public function _ck_formsix_final($file_or_sheet, $squad_id)
	{
		//中六學年成績,!!!不是!!!全學年成績戈個表
		//只比蔡高用處理中六的大表, 之後再優化
		$this->load->helper('ck');
		$school_name = $this->db->get('school_configs')->row()->name;
		$result_unit = [0, 0, 0, 0, 0, 0];
		$squad = $this->squads->get_view($squad_id);
		// $sems = ck_form_six_special_sem();
		// $extras = [];

		$subjects = $this->squads_students->excel_score_and_col_with_order($squad_id, 'col', true);
		$scores = $this->squads_students->get_squads_students_scores_excel_all_final($squad_id);//true is end grade socre
		$type_score = [];
		$zh_type_column_name = ['段一', '段二', '全年'];
		for ($i = 0; $i < count($subjects); $i++) {
			foreach ($zh_type_column_name as $zh_col_name) {
				$type_score[] = $zh_col_name;
			}
		}
		$calculation_data['conduct'] = [
			'A' => 0,
			'A-' => 0,
			'B+' => 0,
			'B' => 0,
			'B-' => 0,
			'C+' => 0,
			'C' => 0,
			'C-' => 0,
			'D' => 0,
		];

		//conduct 未知如何處理
		$conduct = $this->absents_merits->export_absent_merits_excel_final($squad_id);
		$conduct = array_map(function ($v) {
			$v['final_conduct'] = $v['final_conduct'] == -1 ? '--' : $v['final_conduct'];
			return $v;
		}, $conduct);
		//conduct 未知如何處理, 到時要執
		foreach ($scores as $key => $sc) {
			$count_average = 0;
			$count_unit = 0;
			//移走sem 9 因為高三的第三段是 第一 + 第二 / 2 就是佢的分
			$scores[$key]['disciplines'] = ck_form_six_remove_final_sub_final($sc['disciplines']);
			$scores[$key]['unit'] = 0;
			foreach ($scores[$key]['disciplines'] as $dis_id => $dis_score) {
				$unit = $this->db->where('id', $dis_id)->get('disciplines')->row()->unit;
				if ($dis_score[2] < 60) {
					$scores[$key]['unit'] = $scores[$key]['unit'] + $unit;
				}
				$count_average = $count_average + ($dis_score[2] * $unit);
				$count_unit = $count_unit + $unit;
			}
			$scores[$key]['average'] = round(($count_average / $count_unit), 1);
			$scores[$key]['sum_up_conduct'] = ck_format_conduct($conduct[$key]['final_conduct']);
			$calculation_data['conduct'][$scores[$key]['sum_up_conduct']]++;
			$scores[$key]['late'] = ck_format_to_hyphen($conduct[$key]['late']); //遲到
			$scores[$key]['absence'] = ck_format_to_hyphen($conduct[$key]['absence']); //曠課
			$scores[$key]['leave_period'] = ck_format_to_hyphen($conduct[$key]['leave_period']); //請假
		}

		$score_ranking_order = array_column($scores, 'average');
		array_multisort($score_ranking_order, SORT_DESC, $scores);
		$ranking_order_count = 1;
		foreach ($scores as $key => $sc) {
			$scores[$key]['rank'] = $ranking_order_count++;
			switch ($sc['unit']) {
				case 0:
					$result_unit[0]++;
					break;
				case 1:
					$result_unit[1]++;
					break;
				case 2:
					$result_unit[2]++;
					break;
				case 3:
					$result_unit[3]++;
					break;
				case 4:
					$result_unit[4]++;
					break;
				case 5:
					$result_unit[5]++;
					break;
			}
		}
		$student_num_order = array_column($scores, 'student_number');
		array_multisort($student_num_order, SORT_ASC, $scores);
		$this->load->library('my_spreadsheet');
		$year_name = $this->db
			->select('y.name as year_name')
			->where('sq.id', $squad_id)
			->join('years as y', 'y.id = sq.year_id')
			->get('squads as sq')->row()->year_name;
		$static_title_data = array(
			'school_name' => $school_name,
			'year_name' => $year_name,
			'squad' => $squad,
			'sem_name' => '中六學年成績',
		);
		$calculation_data['score'] = ck_all_score_calculate_data_format($scores);
		$spreadsheet = $this->my_spreadsheet->ck_form_six_special($file_or_sheet, $calculation_data, $subjects, $type_score, $scores, $static_title_data, $squad, $result_unit);
		return $spreadsheet;
	}
	//全學年成績總表(分段數)(中學)(通用)
	public function grade_all_scores_excel_final()
	{	session_write_close();
		ini_set("pcre.backtrack_limit", "10000000");
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_ids = $_POST['squad_ids'];
		$is_pdf = $_POST['is_pdf'];
		if ($this->config->item('excel_real_conduct')) {
			$file = 'assets/uploads/export_file/san_all_scores_final.xlsx';
		} else {
			if ($this->config->item('school_type') == '1') {
				//未確定是否只有CK才會用 anthony 
				$file = 'assets/uploads/export_file/ck_all_scores_final.xlsx';
			} else {
				$file = 'assets/uploads/export_file/non_conduct_all_scores_final.xlsx';
			}
		}
		$spreadsheet = $file;
		foreach ($squad_ids as $squad_id) {
			$spreadsheet = $this->_all_scores_excel_final($spreadsheet, $squad_id);
		}
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}

	public function all_scores_excel_final($squad_id=false,$is_pdf=true)
	{	session_write_close();
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		//$_POST['is_pdf']=true; //delete
		$squad_id = $_POST['squad_id']??$squad_id ;
		$is_pdf = $_POST['is_pdf']??$is_pdf;
		if ($this->config->item('excel_real_conduct')) {
			$file = 'assets/uploads/export_file/san_all_scores_final.xlsx';
		} else {
			if ($this->config->item('school_type') == '1') {
				$file = 'assets/uploads/export_file/ck_all_scores_final.xlsx';
			} else {
				//未確定是否只有CK才會用 anthony 
				$file = 'assets/uploads/export_file/non_conduct_all_scores_final .xlsx';
			}
		}
		$spreadsheet = $file;
		$spreadsheet = $this->_all_scores_excel_final($spreadsheet, $squad_id);
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}

	function _all_scores_excel_final($file_or_sheet, $squad_id)
	{
		$this->load->library('export_summary_xlsx');
		$spreadsheet = $this->export_summary_xlsx->_all_scores_excel_final($this, $file_or_sheet, $squad_id);
		return $spreadsheet;
	}


	//santaro 操行紀錄  
	public function grade_all_conducts_excel()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_ids = $_POST['squad_ids'];
		$is_pdf = $_POST['is_pdf'] ?? false;
		$sem = $_POST['sem'];
		$spreadsheet =  'assets/uploads/export_file/san_conduct.xlsx';
		foreach ($squad_ids as $squad_id) {
			$spreadsheet = $this->_all_conducts_excel($spreadsheet, $squad_id, $sem);
		}
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}
	function all_conducts_excel()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_id = $_POST['squad_id'];
		$is_pdf = $_POST['is_pdf'] ?? false;
		$sem = $_POST['sem'];
		$spreadsheet =  'assets/uploads/export_file/san_conduct.xlsx';
		$spreadsheet = $this->_all_conducts_excel($spreadsheet, $squad_id, $sem);
		$this->my_spreadsheet->web_excel_output($spreadsheet, $is_pdf);
	}
	function _all_conducts_excel($file_or_sheet, $squad_id, $sem)
	{
		if ($this->config->item('school_type') == '2') {
			$ss = $this->absents_merits->export_absent_merits_excel($squad_id, $sem);
			foreach ($ss as $idx => $s) {
				if ($s['active'] === '1') {
					foreach ($s as $k => $col) {
						if (in_array($k, ['sem_id', 'student_name', 'subject_teachers', 'absent_merit_id', 'id', 'active', 'student_number'])) {
							continue;
						}
						$ss[$idx][$k] = "--";
					}
				};
			}
			$year = $this->years->newest_year();
			$semester = $this->db->where('id', $sem)->get('semesters')->row();
			$squad = $this->db->where('id', $squad_id)->get('view_squads')->row();
			// $file = 'assets/uploads/export_file/san_conduct.xlsx';
			$this->load->library('my_spreadsheet');
			$spreadsheet = $this->my_spreadsheet->all_conduct_excel($file_or_sheet, $ss, $year->name, $squad, $semester->name, $this->db->get('school_configs')->row()->name);
			return $spreadsheet;
		}
	}

	//該級各班首3名(全學年)(通用)
	function grade_ranking_excel()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		//取各班頭3, 放入排名
		$_POST = json_decode(file_get_contents("php://input"), true);
		$result_array = [];
		foreach ($_POST['squad_ids'] as $squad_id) {
			$rank = $this->squads_students->squad_rank($squad_id); // 默認 final
			usort($rank, function ($a, $b) {;
				return  floatval($a['rank']) - floatval($b['rank']);
			});

			$rank = array_filter($rank, function ($v) {
				return $v['rank'] > 0 && $v['rank'] <= 3;
			});
			$squad = $this->db->where('id', $squad_id)->get('squads')->row();
			$rank = array_map(function ($v) use ($squad) {
				$v['squad_name'] = $squad->view_name;
				return $v;
			}, $rank);
			$result_array = array_merge($result_array, $rank);
		}
		$year = $this->years->get($_POST['year_id']);
		$file = 'assets/uploads/export_file/san_grade_ranking.xlsx';
		$this->load->library('my_spreadsheet');
		$school_name = $this->db->get('school_configs')->row()->name;
		$this->my_spreadsheet->grade_ranking_excel($file, $result_array, $year->name, $school_name);
	}
	//santaro 換證
	function update_idCard_excel($year_id=false)
	{
		if (!$this->config->item('id_card')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}


		date_default_timezone_set("Asia/Taipei");
		$date = date('m/d/Y', time());

		$year = $year_id?$this->db->where('id',$year_id)->get('years')->row():$this->years->newest_year()->id;
		//當前學年就讀學生
		$squads = $this->db->where('year_id', $year->id)->get('squads')->result_array();
		$squad_ids = array_column($squads, 'id');
		$ss = $this->db
			->select('concat(stu.last_name, stu.first_name) as student_name, stu.en_name as student_en_name,  stu.id_card, s.name as squad_name, ss.student_number')
			->where_in('ss.squad_id', $squad_ids)
			->where('ss.active', 0)
			->join('squads as s', 's.id = ss.squad_id')
			->join('students as stu', 'stu.id = ss.student_id')
			->get('squads_students as ss')
			->result_array();

		foreach ($ss as $key => $value) {
			$ss[$key]['id_card'] = json_decode($ss[$key]['id_card']);
		}
		$result_array = [];
		foreach ($ss as $key => $value) {
			if (new DateTime($value['id_card']->expiry_date) <= new DateTime($date)) {
				$result_array[] = $ss[$key];
			}
		}
		// echo json_encode($result_array);


		$file = 'assets/uploads/export_file/san_id_card_update_list.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->update_idCard_excel($file, $result_array, $year->name);
	}

	//補考名單(通用)
	function make_up_excel()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$year = $this->years->newest_year();
		//'ss.id,ss.student_number, concat(stu.last_name, stu.first_name) as student_name, me.discipline_id, me.discipline_name'
		$make_ups = $this->db
			->select('concat(me.squad_student_id,"-",me.discipline_id ) as obj_key,me.squad_student_id,me.discipline_id, me.discipline_name')
			->where_in('ss.squad_id', $_POST['squad_id'])
			->where('ss.active', 0)
			->order_by('ss.student_number', "ASC")
			->join('squads_students as ss', 'me.squad_student_id = ss.id', 'left')
			->get('view_make_up_exams as me')
			->result();
		$make_up_obj = array_column($make_ups, null, 'obj_key');
		$squad_students = [];
		$discipline_obj = array_column($make_ups, 'discipline_name', 'discipline_id');
		$discipline_names = array_values($discipline_obj);
		$discipline_ids = array_keys($discipline_obj);   // unique discipline_id
		$ss_ids = array_keys(array_column($make_ups, null, 'squad_student_id'));   //unique squad_student_id
		foreach ($ss_ids as $ss_id) {
			$st = $this->db->select('squad_student_id,student_number, student_name')->where('squad_student_id', $ss_id)->get('view_squads_students')->row();
			$st->make_up = [];
			$squad_students[] = $st;
		}
		foreach ($squad_students as $ss) {
			foreach ($discipline_ids as $dis_id) {
				$ky = "{$ss->squad_student_id}-{$dis_id}"; //ss+dis
				if (array_key_exists($ky, $make_up_obj)) {
					$ss->make_up[] = "*";
				} else {
					$ss->make_up[] = " ";
				}
			}
			unset($ss->squad_student_id);
		}
		if (count($squad_students) > 0) {
			$school_name = $this->db->get('school_configs')->row()->name;
			$squad = $this->db->where('id', $_POST['squad_id'])->get('view_squads')->row();
			$file = 'assets/uploads/export_file/san_make_up_list.xlsx';
			$this->load->library('my_spreadsheet');
			$this->my_spreadsheet->export_make_up_exam_data($file, $squad_students, $discipline_names, $year->name, $school_name, $squad);
		} else {
			echo 'none';
		}
	}
	//成績需關注學生 santro
	public function export_remark_student()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		} else {
			$_POST = json_decode(file_get_contents("php://input"), true);
			$semester_id = 1;
			$check_type = $_POST['export_type']['value'];
			$txt = '';
			if ($check_type == "score") {
				$txt = 'ts.score<';
			} else {
				$txt = 'sc.' . $check_type . "<";
			}

			$check_type_name = $_POST['export_type']['name'];
			$year = $this->years->newest_year();
			$squads = $this->db->where('year_id', $year->id)->order_by('id', 'ASC')->get('view_squads')->result();
			$data = [];
			$data[] = [$check_type_name . '小於60分之學生與其科目'];
			$data[] = [$year->name];
			$data[] = [];
			$this->db->select('sub.discipline_id')->where('sq.year_id', $year->id)->where($txt, '60');
			if ($check_type == "score") {
				$this->db->where('d.show_pdf', 0);
			}
			$disciplines =	$this->db->where('ts.semester_id', $semester_id)->group_by('sub.discipline_id')
				->join('scores as sc', 'sc.squad_student_id=ts.squad_student_id and ts.subject_id=sc.subject_id and ts.semester_id=sc.semester_id')
				->join('subjects as sub ', 'ts.subject_id=sub.id')
				->join('squads as sq ', 'sq.id=sub.squad_id')
				->join('disciplines as d ', 'd.id=sub.discipline_id')
				->get('temp_subject_total_scores as ts')->result();
			$discipline_ids = array_column($disciplines, 'discipline_id');
			$discipline_name = [];
			if (!empty($disciplines)) {
				$discipline_name = array_column($this->db->where_in('id', $discipline_ids)->get('disciplines')->result(), 'name');
			}
			$title = ['班別', '學號', '姓名', ...$discipline_name];
			$data[] = $title;
			$array_postition = [];
			foreach ($disciplines as $key => $d) {
				$array_postition[] = '-';
			}

			foreach ($squads as $squad) {
				$count = 0;
				$squad_students = $this->db->where('squad_id', $squad->id)->order_by('student_number', 'ASC')->get('view_squads_students')->result();
				foreach ($squad_students as $squad_student) {
					$sub = [...$array_postition];
					$this->db->select('sub.discipline_id,d.name,ts.score,sc.quiz,sc.exam')
						->where('ts.semester_id', $semester_id)
						->where('ts.squad_student_id', $squad_student->squad_student_id)
						->where($txt, '60');
					if ($check_type == "score") {
						$this->db->where('d.show_pdf', 0);
					}
					$scores_analyzes = $this->db->join('scores as sc', 'sc.squad_student_id=ts.squad_student_id and ts.subject_id=sc.subject_id and ts.semester_id=sc.semester_id')
						->join('subjects as sub ', 'ts.subject_id=sub.id')
						->join('disciplines as d ', 'd.id=sub.discipline_id')
						->get('temp_subject_total_scores as ts')->result();

					foreach ($scores_analyzes as $scores_analyze) {
						$dis_index = array_search($scores_analyze->discipline_id, array_column($disciplines, 'discipline_id'));
						$sub[$dis_index] = $scores_analyze->$check_type;
					}
					if (count($scores_analyzes) > 0) {
						array_unshift($sub, $squad->squad_view_name, $squad_student->student_number, $squad_student->student_name);

						$data[] = $sub;
						$count++;
					}
				}

				// $data[] = [];
			}

			$file = 'assets/uploads/student_data.xlsx';
			$this->load->library('my_spreadsheet');
			$this->my_spreadsheet->export_remark_student_data($file, $data);
		}

		// echo json_encode( $data);
	}
	public function export_kid_personal_scores()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		} else {
			$_POST = json_decode(file_get_contents("php://input"), true);
			$data = $this->kid_scores->all_kid_scores_with_topics_and_types($_POST['ss_id']);
			$type_name = $this->db->get('kid_score_types')->result();
			// echo json_encode($data);
			$file = 'assets/uploads/kid_file/kid_personal_scores.xlsx';
			$this->load->library('my_spreadsheet');
			$data['kid_scores'] = array_map(
				function ($v) {
					$v->score = $v->score < 0 ? '--' : $v->score;
					return $v;
				},
				$data['kid_scores']
			);


			$this->my_spreadsheet->export_kid_scores($file, $data['kid_scores'], $data['kid_topics'], $type_name);
		}
	}

	public function export_kid_score_pdf()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$this->load->library('my_pdfmerger');
		$squad_student_ids = array_column($this->squads_students->get_many_by('squad_id', $_POST['squad_id']), 'id');
		$paths = $this->db->where('type', 'kid_sem_score')
			->where('f.is_active', 1)
			->where('f.sem', $_POST['sem'])
			->where_in('f.squad_student_id', $squad_student_ids)
			->order_by('s.student_number', 'ASE')
			->join('squads_students as s', 's.id=f.squad_student_id')
			->get('files as f')->result();
		foreach ($paths as $p) {
			$this->my_pdfmerger->addPDF($p->path, 'all');
		}
		$this->my_pdfmerger->merge('browser', 'TEST3.pdf');
		header('Content-Type: application/vnd.ms-excel');
		header('Content-Disposition: attachment;filename=abc.pdf');
		header('Cache-Control: max-age=0');
	}

	public function export_top_prece()
	{
		// new export 
		// $this->load->model('pdf_model');
		$_POST = json_decode(file_get_contents("php://input"), true);
		$year_id = $_POST['year_id'];
		$s_art = $_POST['science_art'];
		$prec = $_POST['prec'];
		$grade_id = $_POST['grade_id'];
		$art_name = ($s_art == '0' ? '(文科)' : ($s_art == '1' ? '(理科)' : ''));
		$data = $this->squads_students->get_grade_science_art_ranking($year_id, $grade_id, "9", $s_art); // final=9
		$data = array_map(function ($v) {
			unset($v['squad_id']);
			unset($v['science_art']);
			unset($v['id']);
			return $v;
		}, $data);
		usort($data,function($a,$b){
			$a_val=intval( $a['rank']);
			$b_val=intval( $b['rank']);
			if(!is_numeric($a['rank'])){
				$a_val=999;
			}
			if(!is_numeric($b['rank'])){
				$b_val=999;
			}
			return $a_val-$b_val;
		});
		// echo json_encode($data);die();
		if (!empty($data)) {
			$total_len = count($data);
			$index = round(floatval($total_len * $prec), 0);
			$data = array_slice($data, 0, $index);
			$file = 'assets/uploads/grade_student_ranking.xlsx';
			$name = '前' . ($prec * 100) . '%全級排名' . $art_name; //.' 總人數'.$total_amount.'人'.' 缺考'.count($lost_squad_student_ids).'人';
			$this->load->library('my_spreadsheet');
			$this->my_spreadsheet->export_student_ranking($file, $data, $name);
		}
	}

	public function export_subject_rank()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$amount = $_POST['amount'];
		$grade_id = $_POST['subject_data']['grade_id'];
		$year_id = $_POST['subject_data']['year_id'];
		$discipline_id = $_POST['subject_data']['discipline_id'];
		$discipline = $this->disciplines->get($discipline_id)->name;
		$grade = $this->grades->get($grade_id)->name;
		$scores = $this->scores->get_subjcet_top_student_list($_POST['subject_data']);
		// $lost_squad_students = $this->scores->lost_exam_mark_squad_student($grade_id, $year_id, true);
		// $lost_squad_student_ids = array_column(array_values(array_filter($lost_squad_students, function ($v) use ($discipline_id) {
		// 	return $v->discipline_id == $discipline_id;
		// })), 'squad_student_id');
		// $scores = array_values(array_filter($scores, function ($v) use ($lost_squad_student_ids) {
		// 	return !(in_array($v->squad_student_id, $lost_squad_student_ids));
		// }));
		if ($amount == 'all') {
			$data[] = ['班別', '學號', '姓名', '分數', '排名'];
			foreach ($scores as $key => $sc) {
				$data[] = [
					$sc->squad_name,
					$sc->student_number,
					$sc->student_name,
					$sc->avg,
					$key + 1
				];
			}
		} else {
			$tops = array_slice($scores, 0, $amount);
			$downs = array_slice($scores, - ($amount));
			$down_start_rank = intval(count($scores));
			$data = [];
			$data[] = ['前' . $amount . '名', '', '', '', '', '', '', '', '後' . $amount . '名'];
			$data[] = ['班別', '學號', '姓名', '分數', '排名', '', '', '', '班別', '學號', '姓名', '分數', '排名',];
			for ($i = 0; $i < $amount; $i++) {
				$top = $tops[$i];
				$down = $downs[$i];
				$data[] = [
					$top->squad_name,
					$top->student_number,
					$top->student_name,
					$top->avg,
					($i + 1),
					'',
					'',
					'',
					$down->squad_name,
					$down->student_number,
					$down->student_name,
					$down->avg,
					($down_start_rank - $amount + $i + 1),
				];
			}
		}
		$file = 'assets/uploads/subject_top.xlsx';
		$name = $grade . ':' . $discipline . '排名';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_subject_ranking($file, $data, $name);
	}

	public function export_xml($squadId)
	{
		header('Content-type: text/xml');
		header('Content-Disposition: attachment; filename="stud2_001"' . '1' . '".xml"');
		$data = [];
		$squad_ids = [$squadId];
		foreach ($squad_ids as $squad_id) {
			$squad_sra = $this->_export_xml_squad($squad_id);
			$data = [...$data, ...$squad_sra];
		}
		$array = [
			'SRA' => [
				'STUDENT' => $data,
			],
		];

		$result = (new MyArrayToXml($array, 'STUDENT'))->prettify()->toXml();

		echo $result;
	}

	public function extra_activities_template()
	{ // new export 
		$_POST = json_decode(file_get_contents("php://input"), true);
		$this->load->model('pdf_model');
		$file = 'assets/uploads/export_file/san_extra_activities.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->download_excel($file);
	}

	public function score_cert_export_id_card()
	{
		$id_card = $_GET['id_card'];
		$student_id = $this->db->where('json_value(id_card,"$.num")', $id_card)->get('students')->row();
		if (empty($student_id)) {
			$this->db = $this->load->database('old_k12_data', TRUE);
			$student_id = $this->db->where('json_value(id_card,"$.num")', $id_card)->get('students')->row();
		}
		$this->squads_students->db = $this->db;
		$student_id = $student_id->id;
		$this->squads_students->_score_cert_export($student_id);
	}

	public function score_cert_export($student_id)
	{
		// if (!$this->config->item('score_cert')) {
		// 	$this->output->set_status_header('404');
		// 	$this->mPageTitle = '404 Page Not Found';
		// 	$this->render('errors/custom/error_404');
		// 	return false;
		// }
		$this->squads_students->_score_cert_export($student_id);
	}

	public function save_score_cert_export()
	{
		set_time_limit(0); //
		$data = [
			['code' => 2007, 'name' => 'I1A', 'ch_name' => '幼兒魚'], //C>G
			['code' => 2008, 'name' => 'I2D', 'ch_name' => '幼初平'],
			['code' => 2009, 'name' => 'I3A', 'ch_name' => '幼高忠'],

			['code' => 2010, 'name' => 'P1C', 'ch_name' => '小一丙'],
			['code' => 2011, 'name' => 'P2B', 'ch_name' => '小二乙'],
			['code' => 2012, 'name' => 'P3B', 'ch_name' => '小三乙'],

			['code' => 2013, 'name' => 'P4B', 'ch_name' => '小四乙'],
			['code' => 2014, 'name' => 'P5D', 'ch_name' => '小五丁'],
			['code' => 2015, 'name' => 'P6A', 'ch_name' => '小六甲'],

			['code' => 2016, 'name' => 'SG1B', 'ch_name' => '初一乙'],
			['code' => 2017, 'name' => 'SG2B', 'ch_name' => '初二乙'],
			['code' => 2018, 'name' => 'SG3D', 'ch_name' => '初三丁'],

			['code' => 2019, 'name' => 'SC1A', 'ch_name' => '高一甲'],
			['code' => 2006, 'name' => 'SC1C', 'ch_name' => '高一丙'],
			['code' => 2020, 'name' => 'SC2A', 'ch_name' => '高二甲'],
			//['code'=>2005 , 'name'=>'SC2B'  ,'ch_name'=>'高二乙'],
			['code' => 2006, 'name' => 'SC2C', 'ch_name' => '高二丙'],
			['code' => 2021, 'name' => 'SC3A', 'ch_name' => '高三甲'],
			//['code'=>2020 , 'name'=>'SC3D'  ,'ch_name'=>'高三丁'],
		];

		foreach ($data as $d) {
			$this->db = $this->load->database('default', TRUE); //init
			$this->squads_students->db = $this->db;
			$path = "./assets/app/{$d['code']}-{$d['ch_name']}/";
			if (!file_exists($path)) {
				mkdir($path, 0777, true);
			}
			$year_id = $this->db->where('code', $d['code'])->get('years')->row();
			if (empty($year_id)) {
				$this->db = $this->load->database('old_k12_data', TRUE);
				$this->squads_students->db = $this->db;
				$year_id = $this->db->where('code', $d['code'])->get('years')->row();
			}
			$year_id = $year_id->id;
			$squad = $this->db->where('year_id', $year_id)->where('name', $d['name'])->get('squads')->row()->id;
			$squad_students = $this->db->where('squad_id', $squad)->order_by('student_number', 'ASC')->get('view_squads_students')->result();
			foreach ($squad_students as $ss) {
				$file_name = $ss->student_name . '-' . $ss->student_number;
				if (($d['ch_name'] == '小一丙' && $ss->student_number == 23)
					|| ($d['ch_name'] == '小四乙' && $ss->student_number == 27)
					|| ($d['ch_name'] == '初一乙' && $ss->student_number == 25)
					|| ($d['ch_name'] == '初三丁' && $ss->student_number == 27)
					|| ($d['ch_name'] == '高一甲' && $ss->student_number == 24)
					|| ($d['ch_name'] == '高一丙' && $ss->student_number == 31)
					|| ($d['ch_name'] == '高二丙' && $ss->student_number == 10)
				) {
					$file_name = $ss->student_number;
				}
				$save_path = $path . $file_name . ".pdf";
				$this->squads_students->_score_cert_export($ss->student_id, $save_path, 'S');
			}
		}
	}

	public function extra_activitie_score_template()
	{ // new export 
		// $_POST = json_decode(file_get_contents("php://input"), true);
		$this->load->model('pdf_model');
		$file = 'assets/uploads/export_file/san_extra_activities_score.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->download_excel($file);
	}
	function general_score_template()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$file = 'assets/uploads/export_file/san_general_score.xlsx';
		$this->load->library('my_spreadsheet');

		$subject_id = $_POST['subjectId'];

		$subject = $this->subjects->get($subject_id);
		$discipline = $this->disciplines->get($subject->discipline_id);
		$teacher = $this->db->select('concat(last_name, first_name) as name')->where('id', $subject->teacher_id)->get('admin_users')->row();
		$sub_teacher_ids = explode(',', $subject->sub_teacher_ids);
		// echo json_encode($sub_teacher_ids);die();
		$teacher_name = $teacher->name;
		if (!empty($sub_teacher_ids)) {
			$sub_teachers = $this->db->select('concat(last_name, first_name) as name')->where_in('id', $sub_teacher_ids)->get('admin_users')->result();
			$sub_teacher_names = array_column($sub_teachers, 'name');
			$teacher_name = $teacher_name . (implode(',', $sub_teacher_names));
		}
		$squad = $this->squads->get($_POST['squadId']);
		$squad_name = $squad->name;

		$squad_name = $this->db->where('id', $squad->id)->get('view_squads')->row()->name;
		$year_id = $this->years->newest_year()->id;
		$settings = $this->general_scores->score_setting($year_id, $subject_id);

		$sem_id = intval($subject->confirm) + 1;
		$settings = array_filter($settings, function ($v) use ($sem_id) {
			return $v->semester_id == $sem_id;
		});

		$student = array_values($this->db->select('student_number,student_name')->where('squad_id', $squad->id)
		->where('active',0)
		->order_by('student_number', 'ASC')->get('view_squads_students')->result());
		$col_name = ['學號', '姓名'];
		if (!in_array("0", array_column($settings, 'genre'))) {
			$col_name[] = '平時分數';
		}
		foreach ($settings as $s_idx => $s) {
			for ($i = 1; $i <= $s->amount; $i++) {
				if (count($s->detail_settings) > 0 && isset($s->detail_settings[$i - 1]->sub_percentage)) {
					$col_name[] = $s->name . "\n" . $s->detail_settings[$i - 1]->sub_name . "(子項{$s->detail_settings[$i - 1]->sub_percentage}%)" . "\n (合計" . $s->percentage . "%)";
				} else {
					$col_name[] = '第' . $i . "次\n" . $s->name . "\n (合計" . $s->percentage . "%)";
				}
			}
		}
		if (!in_array("1", array_column($settings, 'genre'))) {
			$col_name[] = '考試分數';
		}

		array_unshift($student, ['班級 :', $squad_name, '科目 :', $discipline->name,], ['任教老師:', $teacher_name], $col_name);
		$this->my_spreadsheet->export_students_scores($file, '平時及考試分匯入表', $student);
	}

	function export_user_data_form($id, $path = '-')
	{ //user_id

		// $ch_name=$this->admin_users->ch_name();
		$edu = $this->db->where('teacher_id', $id)->get('teachers_edu_backgrounds')->result_array();
		$edu = array_map(function ($v) {
			unset($v['id']);
			unset($v['teacher_id']);
			return $v;
		}, $edu);
		$work_exp =  $this->db->where('teacher_id', $id)->get('work_experiences')->result_array();
		$work_exp = array_map(function ($v) {
			unset($v['id']);
			unset($v['teacher_id']);
			return $v;
		}, $work_exp);
		$kinship = $this->db->where('teacher_id', $id)->get('teachers_kinships')->result_array();
		$kinship = array_map(function ($v) {
			$v['age'] = date_diff(date_create($v['DOB']), date_create('now'))->y;;
			unset($v['id']);
			unset($v['teacher_id']);
			return $v;
		}, $kinship);
		$data = $this->admin_users->_get_teacher_detail($id);
		$group_key = [
			"comprehensive_number-labor_card" => "C2",
			"dsej_num" => "E2",
			"job_title" => "G2",
			"gender" => "J2",
			"ch_name" => "C3",
			"aka" => "E3",
			"religion" => "H3",
			"en_name" => "C4",
			"baptismal_name" => "H4",
			"id_card-type" => "C5",
			"id_card-num" => "E5",
			"comprehensive_number-tax" => "G5",
			"comprehensive_number-social_insurance" => "J5",
			"address-hometown" => "C6",
			"birth_place" => "E6",
			"DOB" => "G6",
			"marriage" => "J6",
			"address-building_address" => "C7",
			"home_num" => "H7",
			"email" => "C8",
			"phone" => "G8",
			"rank" => "C9",
			"compensation-bank_number" => "G9",
			"compensation-allowance_bank_name" => "C10",
			"compensation-allowance_bank_number" => "G10"
		];
		$edu_key = [
			"organization" => "B",
			"location" => "C",
			"start_year" => "D",
			"major_subject" => "E",
			"certificate" => "G",
			"completed_date" => "H",
		];
		$work_exp_key = [
			"organization" => "A",
			"position" => "C",
			"date" => "E",
			"remark" => "G",
		];
		$kinship_key = [
			"gender" => "B",
			"name" => "C",
			"DOB" => "D",
			"age" => 'F',
			"study_school" => "G",
		];
		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/export_file/user_data.xlsx';
		$data_obj = [];
		$data_obj['data'] = $data;
		$data_obj['group_key'] = $group_key;
		$data_obj['edu'] = $edu;
		$data_obj['edu_key'] = $edu_key;
		$data_obj['work_exp'] = $work_exp;
		$data_obj['work_exp_key'] = $work_exp_key;
		$data_obj['kinship'] = $kinship;
		$data_obj['kinship_key'] = $kinship_key;
		$school_name = $this->db->get('school_configs')->row()->name;
		$this->my_spreadsheet->export_user_data_form($file, $data_obj, $path, $school_name);
	}
	//resg form begin
	//列印資料2_小學部學生註冊表
	function _export_student_resg_form($student_id)
	{
		$this->load->library('my_mpdf_with_html');
		$icon = $this->curriculums->student_icons_with_student_id($student_id);
		$student = $this->students->user_profile_student($student_id);
		$student_curren_info = $this->db->select('ss.id as squad_student_id,y.code as year_code,sq.grade_id,ss.student_number,y.name as year_name,s.student_num,sq.view_name,sq.name as squad_name')->where('s.id', $student_id)
			->order_by('y.code', 'DESC')
			->join('squads_students as ss', 'ss.student_id=s.id', 'left')
			->join('squads as sq', 'sq.id=ss.squad_id', 'left')
			->join('years as y', 'y.id=sq.year_id', 'left')
			->get('students as s')->row_array();

		$icons = $this->db->select('vss.*,f.path,f.id as file_id,f.is_active')
            ->where('vss.student_id', $student_id)
			->where('f.is_active',1)
            ->join('(select * from files where type="icon")  as f', 'vss.squad_student_id=f.squad_student_id', 'right')
			->order_by('vss.grade_id','ASC')
			->get('view_squads_students as vss')
			->result();
		$icon_path=empty($icons)? false:$icons[0]->path;
		$school = "";
		$grade_id = intval($student_curren_info['grade_id']??0);
		if (in_array($grade_id, [1, 2, 3])) {
			$school = "幼稚園";
		}
		if (in_array($grade_id, [4, 5, 6, 7, 8, 9])) {
			$school = "小學";
		}
		if (in_array($grade_id, [10, 11, 12, 13, 14, 15])) {
			$school = "中學";
		}
		$code=$student_curren_info['year_code']??0;
		$pre_code=$code-1;
		$prev_year=$this->db->where('code',$code-1)->get('years')->row();
		$prev_year_id=($prev_year->id??0);
		$student_curren_info['previous_year_info']= $this->db->select("view_name as squad_name, student_number, '{$pre_code}' as year_code")->where('student_id',$student_id)->where('year_id',$prev_year_id)->get('view_squads_students')->row();
		//echo json_encode($student_curren_info);die();
		$html = $this->load->view('generate_pdf/ck_resg', ['icon_path'=>$icon_path,'school' => $school, 'icon' => $icon, 'student' => $student['students_details'], 'student_curren_info' => $student_curren_info], true);

		return $html;

	}
	function export_student_resg_form($id)
	{
		$html=$this->_export_student_resg_form($id);
		$this->my_mpdf_with_html->resg_pdfs([$html], '-', 'I');

	}
	function _export_merge_student_resg_form($squad_id, $is_save = false)
	{
		$save_merge_path = '';
		ini_set('memory_limit', -1);
		$this->load->library('my_pdfmerger');
		$base_path = "./assets/student_files/student_resg_form/";
		if (!file_exists($base_path)) {
			mkdir($base_path, 0777, true);
		}
		$squad_students = $this->db->where('squad_id', $squad_id)->get('squads_students')->result();
		$htmls=[];
		foreach ($squad_students as $ss) {
			$htmls[]=$this->_export_student_resg_form($ss->student_id);
		}
		$file_name = $this->db->where('id', $squad_id)->get('squads')->row()->view_name;
		
		if ($is_save) {
			$this->my_mpdf_with_html->resg_pdfs($htmls, $base_path . $file_name . '.pdf', 'S');
		} else {
			$this->my_mpdf_with_html->resg_pdfs($htmls, $base_path . $file_name . '.pdf', 'I');
		}
		
		return $base_path . $file_name . '.pdf';
	}
	function export_merge_student_resg_form($squad_id)
	{ //for browser output
		$this->_export_merge_student_resg_form($squad_id);
	}
	function zip_grade_student_resg_form()
	{
		session_write_close();
		$_POST = json_decode(file_get_contents("php://input"), true);
		$grade_ids =	$_POST['grade_ids']??0;
		$year_id = $_POST['year_id']??0;
		$squad_ids = $_POST['squad_ids']??false;
		ini_set('memory_limit', -1);
		if($squad_ids){
			$squads = $this->db->select('sq.*,g.name as grade_name')
								->where_in('sq.id', $squad_ids)
								->join('grades as g', 'g.id=sq.grade_id')
								->get('squads as sq')->result();
		
		}else{
			$squads = $this->db->select('sq.*,g.name as grade_name')
							->where_in('sq.grade_id', $grade_ids)
							->where('sq.year_id',$year_id)
							->join('grades as g', 'g.id=sq.grade_id')
							->get('squads as sq')->result();
		}
		//
		$time = time();
		$file_name = "./assets/student_files/student_resg_form_of_grade-{$time}.zip";
		$zip = new ZipArchive();
		$zip->open($file_name, ZipArchive::CREATE);
		foreach ($squads as $sq) {
			$f_path = $this->_export_merge_student_resg_form($sq->id, true);
			$f_name = $sq->view_name . '登記表.pdf';
			if (!empty($f_path)) {
				if (file_exists($f_path)) {
					$zip->addFile($f_path,  $sq->grade_name . "/" . $f_name);
				} else {
					$zip->addFromString($f_name . '_不存在' . '.txt', '   ');
				}
			}
		}
		$zip->close();
		header('Content-Type:text/html;charset=utf-8');
		header('Content-disposition:attachment;filename=' . basename($file_name));
		$filesize = filesize($file_name);
		readfile($file_name);
		header('Content-length:' . $filesize);
		unlink($file_name); //刪文件
		//
	}
	// end resg form
	function _export_student_study_prof($student_id)
	{
		session_write_close();
		$this->load->library('my_mpdf_with_html');
		$icon = $this->curriculums->student_icons_with_student_id($student_id);
		$student = $this->students->user_profile_student($student_id);
		$student_curren_info = $this->db->select('y.code as year_code,sq.name as squad_name,sq.grade_id,ss.student_number,y.name as year_name,s.student_num,sq.view_name')->where('s.id', $student_id)
			->order_by('y.code', 'DESC')
			->join('squads_students as ss', 'ss.student_id=s.id', 'left')
			->join('squads as sq', 'sq.id=ss.squad_id', 'left')
			->join('years as y', 'y.id=sq.year_id', 'left')
			->get('students as s')->row_array();
		$school = "";
		$grade_id = intval($student_curren_info['grade_id']);
		if (in_array($grade_id, [1, 2, 3])) {
			$school = "幼稚園";
		}
		if (in_array($grade_id, [4, 5, 6, 7, 8, 9])) {
			$school = "小學部";
		}
		if (in_array($grade_id, [10, 11, 12, 13, 14, 15])) {
			$school = "中學部";
		}
		////
        $files = $this->db->select('vss.*,f.path,f.id as file_id,f.is_active')
            ->where('vss.student_id', $student_id)
			->where('f.is_active',1)
            ->join('(select * from files where type="icon")  as f', 'vss.squad_student_id=f.squad_student_id', 'right')
			->order_by('vss.grade_id','ASC')
			->get('view_squads_students as vss')
			->result();
		$school_images=['enter'=>false,'k'=>false,'p'=>false,'sg'=>false,'sc'=>false];
		$school_images['enter']=empty($files)?false: $files[0]->path;
		foreach($files as $k=>$img){
			if( in_array($img->grade_id ,['1','2','3'])){	$school_images['k']=$img->path; }
			if( in_array($img->grade_id ,['4','5','6','7','8','9'])){	$school_images['p']=$img->path; }
			if( in_array($img->grade_id, ['10', '11', '12'])){	$school_images['sg']=$img->path; }
			if( in_array($img->grade_id, ['13', '14', '15'])){	$school_images['sc']=$img->path; }
		
		}
        $files = array_values(array_filter($files, function ($v) {
            return $v->is_active !== '0';
        }));
		
		/////
		$html = $this->load->view('generate_pdf/ck_resg2', [ 'school_images'=>$school_images,'school' => $school, 'icon' => $icon, 'student' => $student['students_details'], 'student_curren_info' => $student_curren_info], true);
		return $html;

	}

	function export_student_study_prof($id)
	{
		$html=$this->_export_student_study_prof($id);
		$this->my_mpdf_with_html->resg_pdfs([$html], '-', 'I');

	}
	function _export_merge_student_study_prof($squad_id, $is_save = false)
	{
		ini_set('memory_limit', -1);
		$this->load->library('my_pdfmerger');
		$base_path = "./assets/student_files/student_study_prof/";
		if (!file_exists($base_path)) {
			mkdir($base_path, 0777, true);
		}
		$squad_students = $this->db->where('squad_id', $squad_id)->get('squads_students')->result();
		$htmls=[];
		foreach ($squad_students as $ss) {
			$htmls[]=$this->_export_student_study_prof($ss->student_id);
		}
		$file_name = $this->db->where('id', $squad_id)->get('squads')->row()->view_name;
		if ($is_save) {
			$this->my_mpdf_with_html->resg_pdfs($htmls, $base_path . $file_name . '.pdf', 'S');
		} else {
			$this->my_mpdf_with_html->resg_pdfs($htmls, $base_path . $file_name . '.pdf', 'I');
		}
		return $base_path . $file_name . '.pdf';
	}
	function export_merge_student_study_prof($squad_id)
	{ //for browser output
		$this->_export_merge_student_study_prof($squad_id);
	}
	function zip_grade_student_study_prof()
	{
		session_write_close();
		$_POST = json_decode(file_get_contents("php://input"), true);
		$grade_ids =	$_POST['grade_ids']??0;
		$year_id = $_POST['year_id']??0;
		$squad_ids=$_POST['squad_ids']??false;
		ini_set('memory_limit', -1);
		if($squad_ids){
			$squads = $this->db->select('sq.*,g.name as grade_name')
								->where_in('sq.id', $squad_ids)
								->join('grades as g', 'g.id=sq.grade_id')
								->get('squads as sq')->result();
		
		}else{
			$squads = $this->db->select('sq.*,g.name as grade_name')
							->where_in('sq.grade_id', $grade_ids)
							->where('sq.year_id',$year_id)
							->join('grades as g', 'g.id=sq.grade_id')
							->get('squads as sq')->result();
		}//
		$time = time();
		$file_name = "./assets/student_files/student_study_prof_of_grade-{$time}.zip";
		$zip = new ZipArchive();
		$zip->open($file_name, ZipArchive::CREATE);
		foreach ($squads as $sq) {
			$f_path = $this->_export_merge_student_study_prof($sq->id, true);
			$f_name = $sq->view_name . '學籍表.pdf';
			if (!empty($f_path)) {
				if (file_exists($f_path)) {
					$zip->addFile($f_path,  $sq->grade_name . "/" . $f_name);
				} else {
					$zip->addFromString($f_name . '_不存在' . '.txt', '   ');
				}
			}
		}
		$zip->close();
		header('Content-Type:text/html;charset=utf-8');
		header('Content-disposition:attachment;filename=' . basename($file_name));
		$filesize = filesize($file_name);
		readfile($file_name);
		header('Content-length:' . $filesize);
		unlink($file_name); //刪文件
		//
	}


	//
	//
	function diploma_students()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$year_id = $_POST['year_id'];
		$year_name = $this->db->where('id', $year_id)->get('years')->row()->name;
		$data = [];
		$data[] = ["{$year_name}畢業名單"];
		$data[] = ['班別', '學號', '姓名', '證書編號', '畢業日期'];
		$ss = $this->db->select('ss.view_name,ss.student_number,ss.student_name,LPAD(d.code,5,0) as dip_code,d.graduate_date')
			->where('ss.year_id', $year_id)
			->where('d.active', 1)
			->order_by('ss.grade_id', 'ASC')
			->order_by('ss.code', 'ASC')
			->order_by('ss.student_number', 'ASC')
			->join('view_squads_students as ss', 'ss.squad_student_id=d.squad_student_id')
			->get('diploma as d')->result_array();
		$data = array_merge($data, $ss);

		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/base.xlsx';
		$this->my_spreadsheet->export_cus($file, $data);
	}

	function drop_students()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$year_id = $_POST['year_id'];
		$year_name = $this->db->where('id', $year_id)->get('years')->row()->name;
		$data = [];
		$data[] = ["{$year_name}離校名單"];
		$data[] = ['班別', '學號', '姓名', '離校日期', '原因'];
		$ss = $this->db->select('ss.view_name,ss.student_number,ss.student_name,ds.dropout_date,d.description')
			->where('ss.year_id', $year_id)
			//->where('ds.is_drop', 1)
			->order_by('ss.grade_id', 'ASC')
			->order_by('ss.code', 'ASC')
			->order_by('ss.student_number', 'ASC')
			->join('view_squads_students as ss', 'ss.squad_student_id=ds.squad_student_id')
			->join('dropouts as d', 'd.id=ds.dropout_id')
			->get('dropouts_students as ds')->result_array();
		$data = array_merge($data, $ss);

		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/base.xlsx';
		$this->my_spreadsheet->export_cus($file, $data);
	}


	function squads_students_conducts_ranking()
	{
		if (!$this->config->item('student_score_excel')) {
			$this->output->set_status_header('404');
			$this->mPageTitle = '404 Page Not Found';
			$this->render('errors/custom/error_404');
			return false;
		}
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_id = $_POST['squad_id'];
		$this->load->model('pdf_model');
		$squad = $this->squads->get($squad_id);
		$data = $this->conducts->conduct_rank($squad_id);
		$data = array_map(function ($v) {
			unset($v->squad_student_id);
			return $v;
		}, $data);
		$name = $squad->name . '操行排行榜';
		$file = 'assets/uploads/student_ranking_conducts.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_student_conduct_ranking($file, $data, $name);
	}


	function export_conduct_abs()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_id = $_POST['squad_id'];
		$sem_id = $_POST['sem'];
		$this->absents_merits->_export_conduct_abs($squad_id, $sem_id);
	}



	function export_squad_subject_rank()
	{
		$data = [];
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_id = $_POST['squad_id'];
		$sem=$_POST['sem'];
		$disciplines = $this->db->where('unit>', 0)->order_by('main', "DESC")->order_by('id', "ASC")->get('disciplines')->result();
		foreach ($disciplines as $dis) {
			$name = $dis->name . "({$dis->remark})";
			$query = "if( vss.active = 1, '離', ROW_NUMBER() OVER(PARTITION BY vss.active ORDER BY ts.score DESC))";
			// $query = "ROW_NUMBER() OVER( ORDER BY ts.score DESC)";
			$scores = $this->db
				->select("vss.student_number,vss.student_name,ts.score , {$query} as rank")
				->where('sub.discipline_id', $dis->id)
				->where('ts.semester_id', $sem)
				->where('sub.squad_id', $squad_id)
				->order_by('ts.score', 'DESC')
				->join('view_squads_students as vss', 'vss.squad_student_id=ts.squad_student_id')
				->join('subjects as sub ', 'sub.id=ts.subject_id')
				->get('temp_subject_total_scores as ts')->result();
			///
			foreach ($scores as $idx => $tr) {
				if ($idx === 0) {
					continue;
				}
				$prv_idx = $idx - 1;
				$prv_rank = $scores[$prv_idx];
				if (!is_numeric($prv_rank->rank) || !is_numeric($tr->rank)) {
					continue;
				} // --  ,無, 缺
				if ($tr->score == $prv_rank->score) {
					$scores[$idx]->rank = $prv_rank->rank;
				}
			}
			///
			if (!empty($scores)) {
				$scores = array_values(array_filter($scores, function ($v) {
					return $v->rank <= 3;
				}));
				$data[] = ['name' => $name, 'scores' => $scores];
			}
		}
		$sem_name=array_column( $this->db->get('semesters')->result(),'name','id') ;
		$sem_name=$sem==9?'全學年' :($sem_name[$sem]??'');
		$option['squad_name'] = $this->squads->get($squad_id)->view_name;
		$option['sem_name']=$sem_name;
		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/base.xlsx';
		$this->my_spreadsheet->export_squad_subject_rank($file, $data, $option);
	}

	function _save_temp_user_data_form($id, $file_path)
	{ //include .pdf

		$this->export_user_data_form($id, $file_path);
	}


	public function _export_merge_user_data_form()
	{
		ini_set('memory_limit', -1);
		$this->load->library('my_pdfmerger');
		$base_path = "./assets/student_files/temp_user_data_form/";
		if (!file_exists($base_path)) {
			mkdir($base_path, 0777, true);
		}
		$users = $this->db->get('admin_users')->result();
		$user_ids = array_column($users, 'id');
		foreach ($user_ids as $id) {
			$temp_name = "user_data_form_{$id}.pdf";
			$save_path = $base_path . $temp_name;
			$this->_save_temp_user_data_form($id, $save_path);
			//
			// echo memory_get_usage()."<br>" ;
			$this->my_pdfmerger->addPDF($save_path, 'all');
			//
		}
		$this->my_pdfmerger->merge('browser', 'TEST3.pdf');
		foreach ($user_ids as $id) {
			$temp_name = "user_data_form_{$id}.pdf";
			$save_path = $base_path . $temp_name;
			unlink($save_path);
		}
	}
	function export_merge_user_data_form()
	{
		$this->_export_merge_user_data_form();
	}

	function _diploma_student_part_of_sqaud($year_id, $squad_id, $is_save = true)
	{
		$year_name = $this->db->where('id', $year_id)->get('years')->row()->name;
		$data = [];
		$data[] = ["{$year_name}畢業名單"];
		$data[] = ['班別', '學號', '姓名', '證書編號', '簽收簽署'];
		$ss = $this->db->select('ss.view_name,ss.student_number,ss.student_name,LPAD(d.code,5,0) as dip_code')
			->where('d.year_id', $year_id)
			->where('ss.squad_id', $squad_id)
			->order_by('ss.code', 'ASC')
			->order_by('ss.student_number', 'ASC')
			->join('view_squads_students as ss', 'ss.squad_student_id=d.squad_student_id')
			->get('diploma as d')->result_array();
		$data = array_merge($data, $ss);
		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/base.xlsx'; //org xlsx
		$save_path = "./assets/student_files/temp_diploma_excel/"; //save xlsx
		if (!file_exists($save_path)) {
			mkdir($save_path, 0777, true);
		}
		$save_path = $is_save ? $save_path . "dip-{$year_id}-{$squad_id}.xlsx" : '-';
		$this->my_spreadsheet->export_cus($file, $data, $save_path);
		return $save_path;
	}
	function diploma_for_single_squad($year_id, $squad_id)
	{
		$this->_diploma_student_part_of_sqaud($year_id, $squad_id, false); //false 不save 直接下載
	}
	function diploma_student_part_of_sqaud()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$grade_ids = $_POST['grade_ids'];
		$year_id = $_POST['year_id'];
		$time = time();
		$file_name = "./assets/student_files/diploma_student_part_of_sqaud-{$time}.zip";
		$squads = $this->db->select('sq.*,g.name as grade_name')->where_in('sq.grade_id', $grade_ids)->join('grades as g', 'g.id=sq.grade_id')->get('squads as sq')->result();
		$zip = new ZipArchive();
		$zip->open($file_name, ZipArchive::CREATE);
		foreach ($squads as $sq) {
			$f_path = $this->_diploma_student_part_of_sqaud($year_id, $sq->id);
			$f_name = $sq->view_name . '畢業名單.xlsx';
			if (!empty($f_path)) {
				if (file_exists($f_path)) {
					$zip->addFile($f_path,  $sq->grade_name . "/" . $f_name);
				} else {
					$zip->addFromString($f_name . '_不存在' . '.txt', '   ');
				}
			}
		}
		$zip->close();
		header('Content-Type:text/html;charset=utf-8');
		header('Content-disposition:attachment;filename=' . basename($file_name));
		$filesize = filesize($file_name);
		readfile($file_name);
		header('Content-length:' . $filesize);
		unlink($file_name); //刪文件
	}


	function _all_merit_excel($file_or_sheet, $squad_id, $sem)
	{
		if ($this->config->item('school_type') == '2') {
			$ss = $this->absents_merits->export_absent_merits_excel($squad_id, $sem);
			$year = $this->years->newest_year();
			$semester = $this->db->where('id', $sem)->get('semesters')->row();
			$squad = $this->db->where('id', $squad_id)->get('view_squads')->row();
			$this->load->library('my_spreadsheet');
			$spreadsheet = $this->my_spreadsheet->all_merit_excel($file_or_sheet, $ss, $year->name, $squad, $semester->name, $this->db->get('school_configs')->row()->name);
			return $spreadsheet;
		}
	}
	public function grade_all_merit_excel()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squad_ids = $_POST['squad_ids'];
		$sem = $_POST['sem'];
		$spreadsheet =  'assets/uploads/export_file/san_merit.xlsx';
		foreach ($squad_ids as $squad_id) {
			$spreadsheet = $this->_all_merit_excel($spreadsheet, $squad_id, $sem);
		}
		$this->my_spreadsheet->web_excel_output($spreadsheet);
	}
	// CK
	function conducts_excel_template()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squads_students = $this->db
			->select("ss.student_number, Concat(s.last_name, s.first_name) as name, if(c.conduct_score=-1,'-',c.conduct_score)")
			->where('ss.active', 0)
			->where('ss.squad_id', $_POST['squadId'])
			->where('c.subject_id', $_POST['subjectId'])
			->where('c.semester_id', $_POST['currentSem'])
			->join("students as s", 's.id = ss.student_id', 'left')
			->join('conducts as c', 'c.squad_student_id = ss.id',  'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")->result();
		$subject = $this->subjects->get_view_subject($_POST['subjectId']);
		$data = array(
			"squad_name" => $subject->view_squad_name,
			"teacher_name" => $subject->teacher_name,
			"students" => $squads_students,
			"subject_name" => $subject->discipline_name
		);
		$file = 'assets/uploads/squad_conduct.xlsx';

		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_head_conducts($file, $data, 'teacher');
	}

	//
	function head_merits_excel_template()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$squads_students = $this->db
			->select("ss.student_number, Concat(s.last_name, s.first_name) as name")
			->where('ss.active', 0)
			->where('ss.squad_id', $_POST['squadId'])
			->join("students as s", 's.id = ss.student_id', 'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")->result();
		$squad = $this->squads->get_view_squads_by_id($_POST['squadId']);
		$grade_id=$squad->grade_id;
		$year_id=$squad->year_id;
		$year_code=$this->db->where('id',$year_id)->get('years')->row()->code;
		$school_config=$this->db->get('school_configs')->row();
		$sem=$grade_id<=9? $school_config->p_import_sem :$school_config->f_import_sem ;
		$sems=$this->db->get('semesters')->result();
		$sems=array_column($sems,'name','sem_num');
		$sem_name=$sems[$sem]??'--';
		$data = array(
			'title_name'=>$year_code."-".($year_code+1).'學年'.$sem_name,
			"squad_name" => $squad->squad_view_name,
			"teacher_name" => $squad->head_name,
			"students" => $squads_students
		);
		$file =$grade_id>9? 'assets/uploads/squad_merit_s.xlsx': 'assets/uploads/squad_merit_p.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_head_merit($file, $data);
	}
	function feedbacks_template()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		$ss = $this->db
			->select("ss.student_number, Concat(s.last_name, s.first_name) as name, fs.feedback_text")
			->where('ss.active', 0)
			->where('ss.squad_id', $_POST['squadId'])
			->where('fs.semester_id', $_POST['currentSem'])
			->join("students as s", 's.id = ss.student_id', 'left')
			->join('feedbacks_students as fs', 'fs.squad_student_id = ss.id',  'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")
			->result_array();

		$squad = $this->db->where('id', $_POST['squadId'])->get('view_squads')->row_array();

		$file = 'assets/uploads/download_file/import_feedback.xlsx';

		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_feedback_excel_template($file, $squad['name'], $squad['head_name'], $ss);
	}
	function head_conducts_excel_template()
	{
		$_POST = json_decode(file_get_contents("php://input"), true);
		//
		$colName = 'conduct_scores';
		if (isset($_POST['type'])) {
			$colName = $_POST['type'] == 'manager' ? 'behavior_score' : $colName;
		}
		//
		$squads_students = $this->db
			->select("ss.student_number, Concat(s.last_name, s.first_name) as name, hc.$colName as conduct_scores")
			->where('ss.active', 0)
			->where('ss.squad_id', $_POST['squadId'])
			->where('hc.semester_id', $_POST['currentSem'])
			->join("students as s", 's.id = ss.student_id', 'left')
			->join('head_conducts as hc', 'hc.squad_student_id = ss.id',  'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")->result();
		$squad = $this->squads->get_view_squads_by_id($_POST['squadId']);
		$data = array(
			"squad_name" => $squad->squad_view_name,
			"teacher_name" => $squad->head_name,
			"students" => $squads_students
		);
		$file = 'assets/uploads/squad_conduct.xlsx';

		$this->load->library('my_spreadsheet');
		$type = $colName == "behavior_score" ? "manager" : "head";
		$this->my_spreadsheet->export_head_conducts($file, $data, $type);
	}



	function export_grade_subject_rank($year_id = 3, $grade_id = 10, $sem = 9)
	{
		$data = [];
		$squad_ids = $this->db->where(['year_id' => $year_id, 'grade_id' => $grade_id])->get('squads')->result();
		$squad_ids = array_column($squad_ids, 'id');
		$disciplines = $this->db->where('unit>', 0)->order_by('main', "DESC")->order_by('id', "ASC")->get('disciplines')->result();
		foreach ($disciplines as $dis) {
			$name = $dis->name; //. "({$dis->remark})";
			$query = "if( vss.active = 1, '離', ROW_NUMBER() OVER(PARTITION BY vss.active ORDER BY ts.score DESC))";
			// $query = "ROW_NUMBER() OVER( ORDER BY ts.score DESC)";
			$scores = $this->db
				->select("vss.view_name,vss.student_number,vss.student_name,ts.score , {$query} as rank")
				->where('sub.discipline_id', $dis->id)
				->where('ts.semester_id', $sem)
				->where_in('sub.squad_id', $squad_ids)
				->order_by('ts.score', 'DESC')
				->join('view_squads_students as vss', 'vss.squad_student_id=ts.squad_student_id')
				->join('subjects as sub ', 'sub.id=ts.subject_id')
				->get('temp_subject_total_scores as ts')->result();
			///
			foreach ($scores as $idx => $tr) {
				if ($idx === 0) {
					continue;
				}
				$prv_idx = $idx - 1;
				$prv_rank = $scores[$prv_idx];
				if (!is_numeric($prv_rank->rank) || !is_numeric($tr->rank)) {
					continue;
				} // --  ,無, 缺
				if ($tr->score == $prv_rank->score) {
					$scores[$idx]->rank = $prv_rank->rank;
				}
			}
			///
			if (!empty($scores)) {
				$scores = array_values(array_filter($scores, function ($v) {
					return $v->rank <= 10;
				}));
				$scores = array_slice($scores, 0, 10);
				$data[] = ['name' => $name, 'scores' => $scores];
			}
		}
		if ($sem == 9) {
			$sem_name = "全學年";
		} else {
			$sem_name = $this->db->where('sem_num', $sem)->get('semesters')->row()->name;
		}
		$year_name = $this->db->where('id', $year_id)->get('years')->row()->name;
		$option['year_sem'] = $year_name . '  ' . $sem_name;

		$option['grade_name'] = $this->db->where('id', $grade_id)->get('grades')->row()->name;
		$this->load->library('my_spreadsheet');
		$file = 'assets/uploads/grade_subject_rank.xlsx';
		$this->my_spreadsheet->export_grade_subject_rank($file, $data, $option);
	}

	function export_head_merits_excel()
	{
		$_POST = json_decode(file_get_contents("php://input"), true); //	am.extra_demerit,
		$grade_id=$this->db->where('id',$_POST['squad_id'])->get('squads')->row()->grade_id;
		$sql_txt=$grade_id<=9?'':'am.cheat_test,am.cheat_exam,am.extra_demerit,';
		$squads_students = $this->db
			->select("ss.student_number, Concat(s.last_name, s.first_name) as name ,
				am.late,
				am.absence,
				am.leave_period,
				am.missing_assignment,
				am.infraction,
				$sql_txt
				am.light_demerit,
				am.light_merit,am.conduct_remark")
			->where('ss.active', 0)
			->where('am.semester_id', $_POST['sem'])
			->where('ss.squad_id', $_POST['squad_id'])
			->join('absents_merits as am', "am.squad_student_id=ss.id")
			->join("students as s", 's.id = ss.student_id', 'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")->result();


		$squad = $this->squads->get_view_squads_by_id($_POST['squad_id']);
		$year_code = $this->db->where('id', $squad->year_id)->get('years')->row()->code;
		$sem = $this->db->where('sem_num', $_POST['sem'])->get('semesters')->row()->name;
		$year_name =	$year_code . '-' . ($year_code + 1);
		$data = array(
			"squad_name" => $squad->squad_view_name,
			"teacher_name" => $squad->head_name,
			'title' => "$year_name 年 $sem 學生行檢表",
			"students" => $squads_students
		);
		$file = $grade_id<=9?'assets/uploads/teacher_squad_merit_p.xlsx': 'assets/uploads/teacher_squad_merit.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_teacher_head_merit($file, $data);
	}

	function has_merit_record_squad_student($squad_id, $sem)
	{ //優點提名  退學無
		$records = [];
		$squad = $this->squads->get_view_squads_by_id($squad_id);
		$squads_students = $this->db
			->select("am.id as merit_id,ss.student_number, Concat(s.last_name, s.first_name) as name")
			->where('ss.active', 0)
			->where('am.semester_id', $sem)
			->where('ss.squad_id', $squad_id)
			->join('absents_merits as am', "am.squad_student_id=ss.id")
			->join("students as s", 's.id = ss.student_id', 'left')
			->order_by('ss.student_number', 'ASC')
			->get("squads_students as ss")->result();
		$squads_students_with_merit_id_obj = array_column($squads_students, null, 'merit_id');
		$merit_ids = array_column($squads_students, 'merit_id');
		$merit_records = $this->db->where_in('merit_id', $merit_ids)->where('type', 'light_merit')->get('merits_records')->result();
		foreach ($merit_records as $mr) {
			$ss = $squads_students_with_merit_id_obj[$mr->merit_id];
			$teacher_name=$this->db->select('concat(last_name,first_name) as name')->where('id',$mr->user_id)->get('admin_users')->row();
			$teacher_name=empty($teacher_name)? '--':$teacher_name->name;
			$records[] = [$squad->name, $ss->student_number, $ss->name, $mr->description, $mr->amount,$teacher_name, $mr->suggest_amount];
		}
		return $records;
	}
	function export_merit_record($year_id = 3, $sem = 1) //優點提名
	{
		$records = [];
		$_POST = json_decode(file_get_contents("php://input"), true);
		$sem = $_POST['sem'] ?? $sem;
		$year_id = $_POST['year_id'] ?? $year_id;
		$squads = $this->db->where('year_id', $year_id)->where('grade_id>', 9)->get('squads')->result();
		foreach ($squads as $squad) {
			$records = [...$records, ...$this->has_merit_record_squad_student($squad->id, $sem)];
		}
		$year_code = $this->db->where('id', $year_id)->get('years')->row()->code;
		$sem = $this->db->where('sem_num', $sem)->get('semesters')->row()->name;
		$year_name =	$year_code . '-' . ($year_code + 1);
		$data = array(
			"squad_name" => '',
			"teacher_name" => '',
			'title' => "$year_name 年 $sem 學生優點提名",
			"students" => $records
		);
		$file = 'assets/uploads/merit_record.xlsx';
		$this->load->library('my_spreadsheet');
		$this->my_spreadsheet->export_teacher_head_merit($file, $data);
	}



	public function _export_xml_squad($squadId)
	{
		$grades_map = ['', 'K1', "K2", "K3", 'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6'];
		$students = $this->students->get_student_with_sqaud_id($squadId);
		$squad = $this->squads->get($squadId);
		$grade = $this->grades->get($squad->grade_id);
		$array = [];
		foreach ($students as $key => $stu) {
			$grade_code = $grades_map[$grade->id];
			$school_type_num=$grade->id<=3?"001":'147';
			$ss = $this->db->where('squad_id', $squadId)->where('student_id', $stu->id)->get('squads_students')->row();
			if(isset( $_GET['detail'])){
				$detail_xml=$this->detail_xml_cols($stu,$ss,$squad,$school_type_num);
				$array[] = $detail_xml;
				continue;
			}
			if ($stu->dsej_num == '' || $stu->dsej_num == null) {
				$array[] = [
					'CODE' => '',
					'S_CODE' => $school_type_num,
					'NAME_P' => $stu->en_name,
					'ID_NO' => json_decode($stu->id_card, true)['num'],
					'GRADE' => $grade_code,
					'CLASS' => $squad->code,
					'C_NO' => $ss->student_number
				];
			} else {
				$array[] = [
					'CODE' => $stu->dsej_num,
					'S_CODE' => $school_type_num,
					'NAME_P' => '',
					'ID_NO' => '',
					'GRADE' => $grade_code,
					'CLASS' => $squad->code,
					'C_NO' => $ss->student_number
				];
			}
		}
		return $array;
	}
	function format_field(){
		$places=array_column( $this->place_array(),'name_c') ;
		$idlist=array_column( $this->idlist_array(),'name_c') ;
		$r_area=array_column($this->r_area_array(),'c_name');
		$s_type= ['' ,...array_column($this->s_type_array(),'name')];
		$nation=array_column($this->nation_array(),'name_c' ) ;
		echo json_encode( [ 'places'=>$places,'idlist'=>$idlist,'r_area'=>$r_area,'s_type'=>$s_type ,'nation'=>$nation ]);
	}
	public function detail_xml_cols($stu,$ss,$squad,$school_type_num){
			$sd=$this->db->where('student_id',$stu->id)->get('students_details')->row();
			$places=array_column( $this->place_array(),'id','name_c') ;
			$idlist=array_column( $this->idlist_array(),'id_type','name_c') ;
			$r_area=array_column($this->r_area_array(),'r_area','c_name');
			$s_type=array_column($this->s_type_array(),'id','name');
			$id_card=json_decode($stu->id_card,true)??['type'=>'' ,'num'=>'','issue_area'=>'','expiry_date'=>'' ];
			$nation=array_column($this->nation_array(),'nation','name_c' ) ;
			$address=json_decode($stu->address,true)??["hometown"=>"","nationality"=>"","street_address"=>"","building_address"=>"","living_area"=>"","study_overnight"=>"","overnight_area"=>"","overnight_address"=>"","overnight_building_address"=>"" ];
			$guardian=$this->db->where('student_id',$stu->id)->where('type','guardian')->get('students_guardians')->row();
			$contact=$this->db->where('student_id',$stu->id)->where('type','contact')->get('students_guardians')->row();
			if(empty($guardian)){
				$this->db->insert('students_guardians',['student_id'=>$stu->id,'type'=>'guardian']);
				$guardian=$this->db->where('student_id',$stu->id)->where('type','guardian')->get('students_guardians')->row();
			}
			if(empty($contact)){
				$this->db->insert('students_guardians',['student_id'=>$stu->id,'type'=>'contact']);
				$contact=$this->db->where('student_id',$stu->id)->where('type','contact')->get('students_guardians')->row();
			}
			$student_parent=$this->db->where('student_id',$stu->id)->get('students_parents')->row();

			if(empty($student_parent)){
				$this->db->insert('students_parents',['student_id'=>$stu->id]);
				$student_parent=$this->db->where('student_id',$stu->id)->get('students_parents')->row();
			}
			$guardian_codes=[ $student_parent->father_name=>"M" ,$student_parent->mother_name=>"F" ];
			$same_arr=['是'=>1,'否'=>0];
			$data=[
					"STUD_ID" => $stu->student_num, 
					'CODE' => $stu->dsej_num??'',
					"NAME_C" =>   $stu->last_name, 
					'NAME_P' => $stu->en_name,
					"SEX" => $stu->gender, 
					"B_DATE" => $stu->DOB, 
					"B_PLACE" =>  $places[$sd->birth_place]??$sd->birth_place ,   
					"ID_TYPE" => $idlist[$id_card['type']]??$id_card['type'], 
					'ID_NO' => $id_card['num']??'',
					"I_PLACE" => $places[ $id_card['issue_area']]??$id_card['issue_area'],
					"I_DATE" =>$id_card['issue_date']??'',  
					"V_DATE" => $id_card['expiry_date']??'', 
					"S6_TYPE" =>  $s_type[ $sd->stay_card_type]?? $sd->stay_card_type,
					"S6_IDATE" => $sd->stay_date_start, 
					"S6_VDATE" => $sd->stay_date_end, 
					"NATION" => $nation[$address['nationality']]??$address['nationality'], 
					"ORIGIN" => $address['hometown'], 
					"TEL" => $stu->home_phone,  
					"MOBILE" =>  $stu->phone,  
					"AREA" =>   $r_area[$address['living_area']]??$address['living_area'], 
					"POSTAL_CODE" => $sd->postal_number, 
					"ROAD" => $address['street_address'], 
					"ADDRESS" => $address['building_address'], 
					"SLEEP_SAME" => $same_arr[$sd->live_in_overnight]??1 , 
					"R_AREA" => $r_area[$address['overnight_area']]??$address['overnight_area']  ,
					"RA_DESC" =>  $address['overnight_area'], 
					"S_ROAD" => $address['overnight_address'], 
					"S_ADDRESS" => $address['overnight_building_address'], 
					"FATHER" => $student_parent->father_name, 
					"MOTHER" => $student_parent->mother_name, 
					"F_PROF" => $student_parent->father_job, 
					"M_PROF" => $student_parent->mother_job, 
					"GUARD" => $guardian_codes[ $stu->guardian]??"O", 
					"LIVE_SAME" => $same_arr[$guardian->is_cohabit]??1, 
					"EC_NAME" =>$contact->name, 
					"EC_REL" =>$contact->relationship, 
					"EC_TEL" => $contact->phone." ".$contact->phone2, 
					"EC_AREA" => $r_area[$contact->living_area]??$contact->living_area, 
					"EC_POSTAL_CODE" => $contact->postal_number, 
					"EC_ROAD" =>  $contact->street_address, 
					"EC_ADDRESS" => $contact->building_address, 
					'S_CODE' => $school_type_num??'',
					'GRADE' => $grade_code??'',
					'CLASS' => $squad->code??'',
					'C_NO' => $ss->student_number??'',
					"G_NAME" =>$guardian->name,  
					"G_RELATION" => $guardian->relationship,  
					"G_PROFESSION" => $guardian->job, 
					"G_AREA" => $r_area[$guardian->living_area]??$guardian->living_area, 
					"G_POSTAL_CODE" => $guardian->postal_number, 
					"G_ROAD" =>  $guardian->street_address, 
					"G_ADDRESS" => $guardian->building_address, 
					"G_TEL" =>  $guardian->phone2, 
					"GUARDMOBILE" => $guardian->phone
				 ] ;
			return $data;
	}
	function test(){
		$st=[];
		$squads=$this->db->get('squads')->result();
		foreach($squads as $sq){
			$st=array_merge( $st, $this->_export_xml_squad($sq->id));
		}
		$check_keys=["B_PLACE" ,"ID_TYPE","I_PLACE","S6_TYPE","NATION" ,"AREA","POSTAL_CODE",
						"R_AREA","LIVE_SAME","EC_AREA","G_AREA"];

		$data=[];
		foreach($check_keys as $key ){
			$data[$key]=array_values(array_unique( array_column( $st,$key)) );
		}
		echo json_encode( $data);
		return $data;
	}
	public function export_xml_school($year_id, $school_type = "k") //p s
	{
		$names = ['k' => '幼稚園', 'p' => '小學', 's' => '中學'];
		header('Content-type: text/xml');
		header('Content-Disposition: attachment; filename="stud2_001"' . '1' . '".xml"');
		$grade_id_obj = ['k' => [1, 2, 3], "p" => [4, 5, 6, 7, 8, 9], 's' => [10, 11, 12, 13, 14, 15]];
		$grade_ids = $grade_id_obj[$school_type];
		$data = [];
		$squad_ids = $this->db->where('year_id', $year_id)->where_in('grade_id', $grade_ids)
			->order_by('grade_id', 'ASC')
			->order_by('code', 'ASC')
			->get('squads')->result();
		$squad_ids = array_column($squad_ids, 'id');
		foreach ($squad_ids as $squad_id) {
			$squad_sra = $this->_export_xml_squad($squad_id);
			$data = [...$data, ...$squad_sra];
		}
		$array = [
			'SRA' => [
				'STUDENT' => $data,
			],
		];
		$result = (new MyArrayToXml($array, 'STUDENT'))->prettify()->toXml();

		echo $result;
	}
	function check_rank(){
		$e=$this->squads_students->_end_grade_ranking(60);
		echo json_encode($e);
	}

	function export_cert_pdf(){
		$squad_ids=$this->input_json()['squad_ids'];
		$this->squads_students->_squad_score_cert_export($squad_ids);
	}


	function export_sem_score($subject_id,$sem_id){
		$this->scores->export_sem_score($subject_id,$sem_id);
	
	}



	function place_array(){
		$place = array(
			array('id' => '1','place' => '1','name_c' => '澳門','name_p' => 'MACAU'),
			array('id' => '2','place' => '2','name_c' => '內地','name_p' => 'CHINA CONTINENTAL'),
			array('id' => '3','place' => '3','name_c' => '葡國','name_p' => 'PORTUGAL'),
			array('id' => '4','place' => '4','name_c' => '香港','name_p' => 'HONG KONG'),
			array('id' => '5','place' => '5','name_c' => '美國','name_p' => 'ESTADOS UNIDOS'),
			array('id' => '6','place' => '6','name_c' => '緬甸','name_p' => 'BIRMANIA'),
			array('id' => '7','place' => '7','name_c' => '菲律賓','name_p' => 'FILIPINA'),
			array('id' => '8','place' => '8','name_c' => '加拿大','name_p' => 'CANADA'),
			array('id' => '9','place' => '9','name_c' => '泰國','name_p' => 'TAILANDIA'),
			array('id' => '10','place' => '10','name_c' => '巴西','name_p' => 'BRASIL'),
			array('id' => '11','place' => '11','name_c' => '哥斯達黎加','name_p' => 'COSTA RICA'),
			array('id' => '12','place' => '12','name_c' => '澳洲','name_p' => 'AUSTRALIA'),
			array('id' => '13','place' => '13','name_c' => '委內瑞拉','name_p' => 'VENEZUELA'),
			array('id' => '14','place' => '14','name_c' => '莫桑比克','name_p' => 'MOCAMBIQUE'),
			array('id' => '15','place' => '15','name_c' => '馬達加斯加','name_p' => 'MADAGASCAR'),
			array('id' => '16','place' => '16','name_c' => '英國','name_p' => 'INGLATERRA'),
			array('id' => '17','place' => '17','name_c' => '秘魯','name_p' => 'PERU'),
			array('id' => '18','place' => '18','name_c' => '韓國','name_p' => 'COREIA DO SUL'),
			array('id' => '19','place' => '19','name_c' => '印尼','name_p' => 'INDONESIA'),
			array('id' => '20','place' => '20','name_c' => '安哥拉','name_p' => 'ANGOLA'),
			array('id' => '21','place' => '21','name_c' => '馬來西亞','name_p' => 'MALASIA'),
			array('id' => '22','place' => '22','name_c' => '日本','name_p' => 'JAPAO'),
			array('id' => '23','place' => '23','name_c' => '愛爾蘭','name_p' => 'IRLANDA'),
			array('id' => '24','place' => '24','name_c' => '印度','name_p' => 'INDIA'),
			array('id' => '25','place' => '25','name_c' => '法國','name_p' => 'FRANCA'),
			array('id' => '26','place' => '26','name_c' => '新加坡','name_p' => 'SINGAPURA'),
			array('id' => '27','place' => '27','name_c' => '多明尼加','name_p' => 'REPUBLICA DOMINICANA'),
			array('id' => '28','place' => '28','name_c' => '多米尼克','name_p' => 'DOMINICA'),
			array('id' => '29','place' => '29','name_c' => '哥倫比亞','name_p' => 'COLOMBIA'),
			array('id' => '30','place' => '30','name_c' => '斯里蘭卡','name_p' => 'SRI LANKA'),
			array('id' => '31','place' => '31','name_c' => '巴拿馬','name_p' => 'PANAMA'),
			array('id' => '32','place' => '32','name_c' => '毛里求斯','name_p' => 'MAURICIAS'),
			array('id' => '33','place' => '33','name_c' => '尼加拉瓜','name_p' => 'NICARAGUA'),
			array('id' => '34','place' => '34','name_c' => '南非','name_p' => 'AFRICA DO SUL'),
			array('id' => '35','place' => '35','name_c' => '紐西蘭','name_p' => 'NOVA ZELANDIA'),
			array('id' => '36','place' => '36','name_c' => '東加王國','name_p' => 'TONGA'),
			array('id' => '37','place' => '37','name_c' => '厄瓜多爾','name_p' => 'EQUADOR'),
			array('id' => '38','place' => '38','name_c' => '危地馬拉','name_p' => 'GUATEMALA'),
			array('id' => '39','place' => '39','name_c' => '老撾','name_p' => 'LAOS'),
			array('id' => '40','place' => '40','name_c' => '洪都拉斯','name_p' => 'HONDURAS'),
			array('id' => '41','place' => '41','name_c' => '斐濟','name_p' => 'FIJI'),
			array('id' => '42','place' => '42','name_c' => '德國','name_p' => 'ALEMANHA'),
			array('id' => '43','place' => '43','name_c' => '坦桑尼亞','name_p' => 'TANZANIA'),
			array('id' => '44','place' => '44','name_c' => '柬埔寨','name_p' => 'CAMBOJA'),
			array('id' => '45','place' => '45','name_c' => '海上','name_p' => 'NO MAR'),
			array('id' => '46','place' => '46','name_c' => '利比里亞','name_p' => 'LIBERIA'),
			array('id' => '47','place' => '47','name_c' => '千里達','name_p' => 'TRINDADE'),
			array('id' => '48','place' => '48','name_c' => '西班牙','name_p' => 'ESPANHA'),
			array('id' => '49','place' => '49','name_c' => '伯利茲','name_p' => 'BELIZE'),
			array('id' => '50','place' => '50','name_c' => '阿根廷','name_p' => 'ARGENTINA'),
			array('id' => '51','place' => '51','name_c' => '玻利維亞','name_p' => 'BOLIVIA'),
			array('id' => '52','place' => '52','name_c' => '埃及','name_p' => 'EGIPTO'),
			array('id' => '53','place' => '53','name_c' => '荷蘭','name_p' => 'HOLANDA'),
			array('id' => '54','place' => '54','name_c' => '朝鮮','name_p' => 'COREIA'),
			array('id' => '55','place' => '55','name_c' => '越南','name_p' => 'VIETNAME'),
			array('id' => '56','place' => '56','name_c' => '意大利','name_p' => 'ITALIA'),
			array('id' => '57','place' => '57','name_c' => '薩爾瓦多','name_p' => 'SALVADOR'),
			array('id' => '58','place' => '58','name_c' => '俄羅斯','name_p' => 'RUSSIA'),
			array('id' => '59','place' => '59','name_c' => '新畿內亞','name_p' => 'PAPUA NOVA GUINE'),
			array('id' => '60','place' => '60','name_c' => '烏干達','name_p' => 'UGANDA'),
			array('id' => '61','place' => '61','name_c' => '墨西哥','name_p' => 'MEXICO'),
			array('id' => '62','place' => '62','name_c' => '東非','name_p' => 'E. AFRICA'),
			array('id' => '63','place' => '63','name_c' => '塞席爾','name_p' => 'SEYCHEUES'),
			array('id' => '64','place' => '64','name_c' => '伊朗','name_p' => 'IRAN'),
			array('id' => '65','place' => '65','name_c' => '中國臺灣','name_p' => 'TAIWAN, CHINA'),
			array('id' => '66','place' => '66','name_c' => '巴基斯坦','name_p' => 'PAKISTAN'),
			array('id' => '67','place' => '67','name_c' => '巴林','name_p' => 'BAHRAIN'),
			array('id' => '68','place' => '68','name_c' => '古巴','name_p' => 'CUBA'),
			array('id' => '69','place' => '69','name_c' => '瑞典','name_p' => 'SWEDEN'),
			array('id' => '70','place' => '70','name_c' => '馬耳他','name_p' => 'MALTA'),
			array('id' => '71','place' => '71','name_c' => '比利時','name_p' => 'BELGICA'),
			array('id' => '72','place' => '72','name_c' => '奧地利','name_p' => 'Austria'),
			array('id' => '73','place' => '73','name_c' => '東帝汶','name_p' => 'Timor'),
			array('id' => '74','place' => '74','name_c' => '幾內亞比紹','name_p' => 'Guine Basseu'),
			array('id' => '75','place' => '75','name_c' => '挪威','name_p' => 'Noruega'),
			array('id' => '76','place' => '76','name_c' => '聖露西亞','name_p' => 'St. Lucia'),
			array('id' => '77','place' => '77','name_c' => '丹麥','name_p' => 'Dinamarca'),
			array('id' => '78','place' => '78','name_c' => '烏拉圭','name_p' => 'Uruguay'),
			array('id' => '79','place' => '79','name_c' => '瑞士','name_p' => 'Suica'),
			array('id' => '80','place' => '80','name_c' => '波蘭','name_p' => 'Polanda'),
			array('id' => '81','place' => '81','name_c' => '格林納達','name_p' => 'Grandola'),
			array('id' => '82','place' => '82','name_c' => '南斯拉夫','name_p' => 'Jugoslavia'),
			array('id' => '83','place' => '83','name_c' => '智利','name_p' => 'CHILE'),
			array('id' => '84','place' => '84','name_c' => '突尼斯','name_p' => 'Tnis'),
			array('id' => '85','place' => '85','name_c' => '諾魯/瑙魯','name_p' => 'Nauru'),
			array('id' => '86','place' => '96','name_c' => '佛得角','name_p' => 'Cabo Verde'),
			array('id' => '87','place' => '97','name_c' => '聖多美和林西比','name_p' => 'S緌 Tom e Principe'),
			array('id' => '88','place' => '98','name_c' => '尼泊爾','name_p' => 'Napel'),
			array('id' => '89','place' => '99','name_c' => '匈牙利','name_p' => 'HUNGRIA'),
			array('id' => '90','place' => '100','name_c' => '牙買加','name_p' => 'Jamaica'),
			array('id' => '91','place' => '101','name_c' => '芬蘭','name_p' => 'Finland'),
			array('id' => '92','place' => '102','name_c' => '保加利亞','name_p' => 'Bugarlia'),
			array('id' => '93','place' => '103','name_c' => '土耳其','name_p' => 'Turkia'),
			array('id' => '94','place' => '104','name_c' => '尼日利亞','name_p' => 'NIGERIA'),
			array('id' => '95','place' => '105','name_c' => '阿拉伯聯合酋長國','name_p' => 'Arabes Unidos (Estados dos Emirados)'),
			array('id' => '96','place' => '106','name_c' => '多哥','name_p' => 'Togo'),
			array('id' => '97','place' => '107','name_c' => '羅馬尼亞','name_p' => 'ROM冇IA'),
			array('id' => '98','place' => '108','name_c' => '烏克蘭','name_p' => 'Ucr滱ia'),
			array('id' => '99','place' => '109','name_c' => '希臘','name_p' => 'GREケCIAケ'),
			array('id' => '100','place' => '110','name_c' => '亞美尼亞','name_p' => 'REPUBLIC OF ARMENIA'),
			array('id' => '101','place' => '111','name_c' => '杜拜','name_p' => 'DUBAI'),
			array('id' => '102','place' => '112','name_c' => '馬爾代夫','name_p' => 'Maldivas'),
			array('id' => '103','place' => '113','name_c' => '敘利亞','name_p' => 'Siria'),
			array('id' => '104','place' => '114','name_c' => '馬紹爾群島','name_p' => 'MARSHALL ISLANDS'),
			array('id' => '105','place' => '115','name_c' => '馬朱羅','name_p' => 'MAJURO'),
			array('id' => '106','place' => '116','name_c' => '捷克','name_p' => 'CZECH REPUBLIC'),
			array('id' => '107','place' => '999','name_c' => '不詳','name_p' => 'INCONHECIDO')
		  );
		  return $place;
		}
	function idlist_array(){
		$idlist = array(
			array('id' => '8','id_type' => 'BIR','name_c' => '澳門居民身份證','name_p' => 'BILHETE DE IDENTIDADE DE RESIDENTE DE MACAU'),
			array('id' => '9','id_type' => 'BIRNP','name_c' => '非永久性居民身份證','name_p' => 'Bilhete de identidade de residente n緌 permanente'),
			array('id' => '10','id_type' => 'BIRP','name_c' => '永久性居民身份證','name_p' => ' Bilhete de identidade de residente permanente'),
			array('id' => '3','id_type' => 'ADN','name_c' => '澳門出生登記','name_p' => 'ASSENTO DE NASCIMENTO'),
			array('id' => '4','id_type' => 'BIC','name_c' => '領事身份證','name_p' => 'Billhete de Identidade Consular'),
			array('id' => '5','id_type' => 'BICHN','name_c' => '中國居民身份證','name_p' => 'Bilhelte de Identidade da RPC'),
			array('id' => '6','id_type' => 'BIE','name_c' => '非葡藉認別證','name_p' => 'BILHETE DE IDENTIDADE DE CIDADAO ESTRANGEIRO'),
			array('id' => '7','id_type' => 'BIN','name_c' => '葡藉認別證','name_p' => 'BILHETE DE IDENTIDADE DE CIDADAO NACIONAL'),
			array('id' => '11','id_type' => 'CEDUL','name_c' => '葡國中央登記','name_p' => 'CEDULA PESSOAL'),
			array('id' => '12','id_type' => 'CI','name_c' => '簽證身份書','name_p' => 'Document of Identity for Visa Purpose'),
			array('id' => '13','id_type' => 'CIP','name_c' => '澳門身份證','name_p' => 'CEDULA DE IDENTIFICACAO POLICIAL'),
			array('id' => '14','id_type' => 'COB','name_c' => '香港出生登記','name_p' => 'CERTIFICATE OF BIRTH'),
			array('id' => '15','id_type' => 'CPAS','name_c' => '中國護照','name_p' => 'PASSPORTE CHINES'),
			array('id' => '16','id_type' => 'CPASS','name_c' => '中國通行証','name_p' => 'SALVO-CONDUTO DA CHINA'),
			array('id' => '17','id_type' => 'HKID','name_c' => '香港身份證','name_p' => 'HONG KONG IDENTITY CARD'),
			array('id' => '18','id_type' => 'HKPAS','name_c' => '香港特區護照','name_p' => 'HKSAR passport'),
			array('id' => '19','id_type' => 'HKREP','name_c' => '回港証','name_p' => 'RE-ENTRY PERMIT'),
			array('id' => '20','id_type' => 'PAS','name_c' => '外國護照','name_p' => 'PASSPORTE'),
			array('id' => '21','id_type' => 'PPAS','name_c' => '葡國護照','name_p' => 'PASSPORTE PORTUGUES'),
			array('id' => '22','id_type' => 'RECIB','name_c' => '移民局收條','name_p' => 'RECIBO'),
			array('id' => '23','id_type' => 'TITNR','name_c' => '非本地勞工身份咭','name_p' => 'TITULO DE IDENTIFICACAO DE TRABALHADOR NAO-RESIDENTE'),
			array('id' => '24','id_type' => 'TNR','name_c' => '外地僱員身份認別證','name_p' => 'TITULO DE IDENTIFICACAO DE TRABALHADOR NAO-RESIDENTE'),
			array('id' => '25','id_type' => 'TPT','name_c' => '臨時逗留證','name_p' => 'TITULO DE PERMANENCIA TEMPORARIA'),
			array('id' => '26','id_type' => 'TRP','name_c' => '永久居留證','name_p' => 'TITULO DE RESIDENCIA (PERMANENTE)'),
			array('id' => '27','id_type' => 'TRT','name_c' => '臨時居留證','name_p' => 'TITULO DE RESIDENCIA (TEMPORARIO)'),
			array('id' => '1','id_type' => '','name_c' => '空','name_p' => 'Vazio'),
			array('id' => '2','id_type' => '*','name_c' => '*','name_p' => 'NULO'),
		);
		return $idlist;
	}

	function nation_array(){
		$nation = array(
			array('id' => '1','nation' => '1','name_c' => '葡國','name_p' => 'PORTUGUESA'),
			array('id' => '2','nation' => '2','name_c' => '中國','name_p' => 'CHINESA'),
			array('id' => '3','nation' => '3','name_c' => '英國','name_p' => 'INGLESA'),
			array('id' => '4','nation' => '4','name_c' => '美國','name_p' => 'ESTADOS UNIDOS'),
			array('id' => '5','nation' => '5','name_c' => '菲律賓','name_p' => 'FILIPINA'),
			array('id' => '6','nation' => '6','name_c' => '加拿大','name_p' => 'CANADA'),
			array('id' => '7','nation' => '7','name_c' => '緬甸','name_p' => 'BIRMANIA'),
			array('id' => '8','nation' => '8','name_c' => '泰國','name_p' => 'TAILANDIA'),
			array('id' => '9','nation' => '9','name_c' => '哥斯達黎加','name_p' => 'COSTA RICA'),
			array('id' => '10','nation' => '10','name_c' => '東加王國','name_p' => 'TONGA'),
			array('id' => '11','nation' => '11','name_c' => '委內瑞拉','name_p' => 'VENEZUELA'),
			array('id' => '12','nation' => '12','name_c' => '澳洲','name_p' => 'AUSTRALIA'),
			array('id' => '13','nation' => '13','name_c' => '日本','name_p' => 'JAPAO'),
			array('id' => '14','nation' => '14','name_c' => '韓國','name_p' => 'COREIA DO SUL'),
			array('id' => '15','nation' => '15','name_c' => '秘魯','name_p' => 'PERU'),
			array('id' => '16','nation' => '16','name_c' => '印度','name_p' => 'INDIA'),
			array('id' => '17','nation' => '17','name_c' => '洪都拉斯','name_p' => 'HONDURAS'),
			array('id' => '18','nation' => '18','name_c' => '多明尼加共','name_p' => 'REPUBLICA DOMINICANA'),
			array('id' => '19','nation' => '19','name_c' => '多米尼克','name_p' => 'DOMINICA'),
			array('id' => '20','nation' => '20','name_c' => '馬來西亞','name_p' => 'MALASIA'),
			array('id' => '21','nation' => '21','name_c' => '巴西','name_p' => 'BRASIL'),
			array('id' => '22','nation' => '22','name_c' => '印尼','name_p' => 'INDONESIA'),
			array('id' => '23','nation' => '23','name_c' => '馬達加斯加','name_p' => 'MADAGASCAR'),
			array('id' => '24','nation' => '24','name_c' => '塞拉里昂','name_p' => 'SERRA LEONA'),
			array('id' => '25','nation' => '25','name_c' => '紐西蘭','name_p' => 'NOVA ZELANDIA'),
			array('id' => '26','nation' => '26','name_c' => '法國','name_p' => 'FRANCA'),
			array('id' => '27','nation' => '27','name_c' => '斯里蘭卡','name_p' => 'SRI LANKA'),
			array('id' => '28','nation' => '28','name_c' => '愛爾蘭','name_p' => 'IRLANDA'),
			array('id' => '29','nation' => '29','name_c' => '厄瓜多爾','name_p' => 'EQUADOR'),
			array('id' => '30','nation' => '30','name_c' => '伯利茲','name_p' => 'BELIZE'),
			array('id' => '31','nation' => '31','name_c' => '德國','name_p' => 'ALEMANHA'),
			array('id' => '32','nation' => '32','name_c' => '新加坡','name_p' => 'SINGAPURA'),
			array('id' => '33','nation' => '33','name_c' => '巴拿馬','name_p' => 'PANAMA'),
			array('id' => '34','nation' => '34','name_c' => '毛里求斯','name_p' => 'MAURICIAS'),
			array('id' => '35','nation' => '35','name_c' => '尼加拉瓜','name_p' => 'NICARAGUA'),
			array('id' => '36','nation' => '36','name_c' => '危地馬拉','name_p' => 'GUATEMALA'),
			array('id' => '37','nation' => '37','name_c' => '西班牙','name_p' => 'ESPANHA'),
			array('id' => '38','nation' => '38','name_c' => '坦桑尼亞','name_p' => 'TANZANIA'),
			array('id' => '39','nation' => '39','name_c' => '莫桑比克','name_p' => 'MOCAMBIQUE'),
			array('id' => '40','nation' => '40','name_c' => '斐濟','name_p' => 'FIJI'),
			array('id' => '41','nation' => '41','name_c' => '朝鮮','name_p' => 'COREIA'),
			array('id' => '42','nation' => '42','name_c' => '奧地利','name_p' => 'AUSTRIA'),
			array('id' => '43','nation' => '43','name_c' => '阿根廷','name_p' => 'ARGENTINA'),
			array('id' => '44','nation' => '44','name_c' => '南非','name_p' => 'AFRICA DO SUL'),
			array('id' => '45','nation' => '45','name_c' => '玻利維亞','name_p' => 'BOLIVIA'),
			array('id' => '46','nation' => '46','name_c' => '埃及','name_p' => 'EGIPTO'),
			array('id' => '47','nation' => '47','name_c' => '挪威','name_p' => 'NORUEGA'),
			array('id' => '48','nation' => '48','name_c' => '瑞士','name_p' => 'SUICA'),
			array('id' => '49','nation' => '49','name_c' => '瑞典','name_p' => 'SUECIA'),
			array('id' => '50','nation' => '50','name_c' => '巴布亞新畿','name_p' => 'PAPUA NOVA GUINE'),
			array('id' => '51','nation' => '51','name_c' => '烏干達','name_p' => 'UGANDA'),
			array('id' => '52','nation' => '52','name_c' => '墨西哥','name_p' => 'MEXICO'),
			array('id' => '53','nation' => '53','name_c' => '意大利','name_p' => 'ITALY'),
			array('id' => '54','nation' => '54','name_c' => '巴基斯坦','name_p' => 'PAKISTAN'),
			array('id' => '55','nation' => '55','name_c' => '塞席爾','name_p' => 'SEYCHEUES'),
			array('id' => '56','nation' => '56','name_c' => '古巴','name_p' => 'CUBA'),
			array('id' => '57','nation' => '57','name_c' => '瑞典','name_p' => 'SWEDEN'),
			array('id' => '58','nation' => '58','name_c' => '馬耳他','name_p' => 'MALTA'),
			array('id' => '59','nation' => '59','name_c' => '比利時','name_p' => 'BELGICA'),
			array('id' => '60','nation' => '60','name_c' => '越南','name_p' => 'VIETNAM'),
			array('id' => '61','nation' => '61','name_c' => '奧地利','name_p' => 'Austria'),
			array('id' => '62','nation' => '62','name_c' => '荷蘭','name_p' => 'Holanda'),
			array('id' => '63','nation' => '63','name_c' => '聖露西亞','name_p' => 'St. Lucia'),
			array('id' => '64','nation' => '64','name_c' => '丹麥','name_p' => 'Dinamarca'),
			array('id' => '65','nation' => '65','name_c' => '柬埔寨','name_p' => 'Camboja'),
			array('id' => '66','nation' => '66','name_c' => '千里達','name_p' => 'Trindade'),
			array('id' => '67','nation' => '67','name_c' => '烏拉圭','name_p' => 'Uraguay'),
			array('id' => '68','nation' => '68','name_c' => '波蘭','name_p' => 'Polandesa'),
			array('id' => '69','nation' => '69','name_c' => '幾內亞比紹','name_p' => 'Guine Basseu'),
			array('id' => '70','nation' => '70','name_c' => '安哥拉','name_p' => 'Angolense'),
			array('id' => '71','nation' => '71','name_c' => '俄羅斯','name_p' => 'Russo'),
			array('id' => '72','nation' => '72','name_c' => '南斯拉夫','name_p' => 'Jugoslav'),
			array('id' => '73','nation' => '73','name_c' => '哥倫比亞','name_p' => 'Columbia'),
			array('id' => '74','nation' => '74','name_c' => '智利','name_p' => 'CHILE'),
			array('id' => '75','nation' => '75','name_c' => '匈牙利','name_p' => 'Hungria'),
			array('id' => '76','nation' => '76','name_c' => '西薩摩亞','name_p' => 'Samoa Ocidental'),
			array('id' => '77','nation' => '77','name_c' => '岡比亞','name_p' => 'Gambia'),
			array('id' => '78','nation' => '78','name_c' => '諾魯/瑙魯','name_p' => 'Nauru'),
			array('id' => '79','nation' => '79','name_c' => '聖多美和林西比','name_p' => 'S緌 Tom e Principe'),
			array('id' => '80','nation' => '80','name_c' => '基里巴斯','name_p' => 'Kiribati'),
			array('id' => '81','nation' => '81','name_c' => '尼泊爾','name_p' => 'Napel'),
			array('id' => '82','nation' => '82','name_c' => '牙買加','name_p' => 'Jamaica'),
			array('id' => '83','nation' => '83','name_c' => '芬蘭','name_p' => 'Finland'),
			array('id' => '84','nation' => '84','name_c' => '保加利亞','name_p' => 'Bugarlia'),
			array('id' => '85','nation' => '85','name_c' => '土耳其','name_p' => 'Turkia'),
			array('id' => '86','nation' => '86','name_c' => '尼日利亞','name_p' => 'NIGERIA'),
			array('id' => '87','nation' => '87','name_c' => '阿拉伯聯合酋長國','name_p' => 'Arabes Unidos (Estados dos Emirados)'),
			array('id' => '88','nation' => '88','name_c' => '多哥','name_p' => 'Togo'),
			array('id' => '89','nation' => '89','name_c' => '羅馬尼亞','name_p' => 'ROMENO'),
			array('id' => '90','nation' => '90','name_c' => '亞美尼亞','name_p' => 'REPUBLIC OF ARMENIA'),
			array('id' => '91','nation' => '91','name_c' => '杜拜','name_p' => 'DUBAI'),
			array('id' => '92','nation' => '92','name_c' => '馬爾代夫','name_p' => 'Maldivas'),
			array('id' => '93','nation' => '93','name_c' => '希臘','name_p' => 'Hellenic'),
			array('id' => '94','nation' => '94','name_c' => '烏克蘭','name_p' => 'Ukrainian'),
			array('id' => '95','nation' => '95','name_c' => '敘利亞','name_p' => 'Siria'),
			array('id' => '96','nation' => '96','name_c' => '馬紹爾群島','name_p' => 'MARSHALL ISLANDS'),
			array('id' => '97','nation' => '97','name_c' => '捷克','name_p' => 'CZECH REPUBLIC'),
			array('id' => '98','nation' => '999','name_c' => '不詳','name_p' => 'INCONHECIDO')
		  );
		return $nation;
	}

	function r_area_array(){
		$r_area = array(
			array('id' => '1','r_area' => 'M','c_name' => '澳門','e_name' => 'Macau'),
			array('id' => '2','r_area' => 'T','c_name' => '氹仔','e_name' => 'Taipa'),
			array('id' => '3','r_area' => 'C','c_name' => '路環','e_name' => 'Colone'),
			array('id' => '4','r_area' => 'ZH','c_name' => '珠海','e_name' => 'ZhuHai'),
			array('id' => '5','r_area' => 'ZS','c_name' => '中山','e_name' => 'ZhongShan'),
			array('id' => '6','r_area' => 'O','c_name' => '其他','e_name' => 'Others')
		  );
		return $r_area;
	}
	function s_type_array(){
			$s_type=[['id'=>1, 'name'=>'永久'],
					['id'=>2, 'name'=>'有限期'] ,
					['id'=>3, 'name'=>'其他逗留許可'] 
					];
			return $s_type;
	}
}
