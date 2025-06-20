<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ConfigSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // DB::table('configs')->insert([
        //     'key' => 'grade_categories',
        //     'value' => '[
        //         {"value":"P1","label":"P1"},
        //         {"value":"P2","label":"P2"},
        //         {"value":"P3","label":"P3"},
        //         {"value":"P4","label":"P4"},
        //         {"value":"P5","label":"P5"},
        //         {"value":"P6","label":"P6"},
        //         {"value":"SC1","label":"SC1"},
        //         {"value":"SC2","label":"SC2"},
        //         {"value":"SC3","label":"SC3"},
        //         {"value":"SG1","label":"SG1"},
        //         {"value":"SG2","label":"SG2"},
        //         {"value":"SG3","label":"SG3"},
        //     ]',
        // ]);
        DB::table('configs')->insert([
            'key'=>'suid_prefix',
            'value' =>'"S"'
        ]);
        DB::table('configs')->insert([
            'key'=>'year_terms',
            'value' =>'[{"value":1,"label":"第一段"},{"value":2,"label":"第二段"},{"value":3,"label":"第三段"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'klass_letters',
            'value'=>'[
                {"value":"A","label":"A"},{"value":"B","label":"B"},{"value":"C","label":"C"},{"value":"D","label":"D"},
                {"value":"E","label":"E"},{"value":"F","label":"F"},{"value":"G","label":"G"},{"value":"H","label":"H"},
                {"value":"I","label":"I"},{"value":"J","label":"J"},{"value":"K","label":"K"},{"value":"L","label":"L"},
                {"value":"M","label":"M"},{"value":"N","label":"N"},{"value":"O","label":"O"},{"value":"P","label":"P"},
                {"value":"Q","label":"Q"},{"value":"R","label":"R"},{"value":"S","label":"S"},{"value":"T","label":"T"}
            ]'
        ]);

        //the values are same as gradeYear, j

        DB::table('configs')->insert([
            'key'=>'grade_years',
            'value' =>'[
                {"value": 1, "label": "K1", "initial": "K","level":1,"zh_name":"幼兒"},
                {"value": 2, "label": "K2", "initial": "K","level":2,"zh_name":"幼初"},
                {"value": 3, "label": "K3", "initial": "K","level":3,"zh_name":"幼高"},
                {"value": 4, "label": "P1", "initial": "P","level":1,"zh_name":"小一"},
                {"value": 5, "label": "P2", "initial": "P","level":2,"zh_name":"小二"},
                {"value": 6, "label": "P3", "initial": "P","level":3,"zh_name":"小三"},
                {"value": 7, "label": "P4", "initial": "P","level":4,"zh_name":"小四"},
                {"value": 8, "label": "P5", "initial": "P","level":5,"zh_name":"小五"},
                {"value": 9, "label": "P6", "initial": "P","level":6,"zh_name":"小六"},
                {"value": 10, "label": "F1", "initial": "F","level":1,"zh_name":"初一"},
                {"value": 11, "label": "F2", "initial": "F","level":2,"zh_name":"初二"},
                {"value": 12, "label": "F3", "initial": "F","level":3,"zh_name":"初三"},
                {"value": 13, "label": "F4", "initial": "F","level":1,"zh_name":"高一"},
                {"value": 14, "label": "F5", "initial": "F","level":2,"zh_name":"高二"},
                {"value": 15, "label": "F6", "initial": "F","level":3,"zh_name":"高三"}
            ]',
            'remark'=>'value 用時用於gradeYear, 主要用於Year_model autoGenerate function上。
                        K1-K3: 1-3
                        P1-P6: 4-9
                        F1-F6: 10-15'
        ]);
        DB::table('configs')->insert([
            'key' => 'score_template',
            'value' =>'{
                "term": [{
                    "value": "REGULAR",
                    "label": "平時",
                    "term_id": 1,
                    "is_total": 0
                }, {
                    "value": "EXAM",
                    "label": "考試",
                    "term_id": 1,
                    "is_total": 0
                }, {
                    "value": "YEAR",
                    "label": "總分",
                    "term_id": 1,
                    "is_total": 1
                }, {
                    "value": "REGULAR",
                    "label": "平時",
                    "term_id": 2,
                    "is_total": 0
                }, {
                    "value": "EXAM",
                    "label": "考試",
                    "term_id": 2,
                    "is_total": 0
                }, {
                    "value": "YEAR",
                    "label": "總分",
                    "term_id": 2,
                    "is_total": 1
                }, {
                    "value": "FINAL",
                    "label": "學年總分",
                    "term_id": 9,
                    "is_total": 0,
                    "formular": "=T1*.5+T2*.5"
                }],
                "comment": [{
                    "value": "COMMENT",
                    "label": "描述"
                }]
            }'
        ]);
        DB::table('configs')->insert([
            'key'=>'klass_head_behaviour',
            'value' =>'true'
        ]);
        DB::table('configs')->insert([
            'key'=>'subject_head_behaviour',
            'value' =>'true'
        ]);
        DB::table('configs')->insert([
            'key'=>'study_streams',
            'value' =>'[{"value":"ALL","label":"全科"},{"value":"ART","label":"文科"},{"value":"SCI","label":"理科"},{"value":"AAS","label":"文理科"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'subject_types',
            'value'=>'[{"value":"COM","label":"必修"},{"value":"ELE","label":"選修"}]'
        ]);
        //'value' =>'[{"value":"SUB","label":"學科"},{"value":"ATT","label":"生活習慣和態度"},{"value":"RPAL","label":"獎懲遲缺"},{"value":"LES","label":"餘暇活動"},{"value":"OVA","label":"總體評分"}]'
        DB::table('configs')->insert([
            'key' => 'student_state',
            'value' => '{"ACT": "Active","RES": "Resigned"}',
        ]);
        DB::table('configs')->insert([
            'key' => 'year_creation',
            'value' => '{ "kgrade":3, "kklass":20, "kgradeDefault":0, "kklassDefault":0, "pgrade":6, "pklass":20, "pgradeDefault":6, "pklassDefault":4, "sgrade":6, "sklass":20, "sgradeDefault":6, "sklassDefault":4 }',
        ]);
        DB::table('configs')->insert([
            'key'=>'habit_columns',
            'value' =>'[{"name":"health_1","label":"衣服鞋襪整齊清潔","short":"整潔"},
                {"name":"health_2","label":"常剪指甲","short":"指甲"},
                {"name":"health_3","label":"懂得使用手帕或紙巾","short":"紙巾"},
                {"name":"health_4","label":"不把手指雜物放進口裡","short":"手指"},
                {"name":"health_5","label":"能把癈物投入癈紙箱內","short":"癈物"},
                {"name":"behaviour_1","label":"守秩序不喧嚷","short":"喧讓"},
                {"name":"behaviour_2","label":"留心聽講","short":"聽講"},
                {"name":"behaviour_3","label":"坐立行走姿勢正確","short":"姿勢"},
                {"name":"behaviour_4","label":"離開座位把物件桌椅整理好","short":"桌椅"},
                {"name":"behaviour_5","label":"愛護公物用後放回原處","short":"公物"},
                {"name":"behaviour_6","label":"遵守校規","short":"校規"},
                {"name":"social_1","label":"守時","short":"守時"},
                {"name":"social_2","label":"尊敬師長,友愛和睦","short":"尊敬"},
                {"name":"social_3","label":"樂於助人","short":"助人"},
                {"name":"social_4","label":"會和別人分享及輪候","short":"分享"},
                {"name":"social_5","label":"誠實坦白肯認錯","short":"誠實"}]'
        ]);
        // DB::table('configs')->insert([
        //     'key'=>'behaviour_genres',
        //     'value'=>'[{"value":"LATE","label":"遲到"},
        //         {"value":"ABSENT","label":"缺席"},
        //         {"value":"DEMERIT","label":"缺點"},
        //         {"value":"FAULT_BIG","label":"大過"},
        //         {"value":"FAULT_SMALL","label":"小過"},
        //         {"value":"CREDIT_BIG","label":"大功"},
        //         {"value":"CREDIT_SMALL","label":"小功"},
        //         {"value":"MERIT","label":"優點"}]'
        // ]);

        DB::table('configs')->insert([
            'key'=>'score_letters',
            'value'=>'
            [
                {
                   "letter":"A+",
                   "min":97,
                   "max":100
                },
                {
                   "letter":"A",
                   "min":93,
                   "max":96
                },
                {
                   "letter":"A-",
                   "min":90,
                   "max":92
                },
                {
                   "letter":"B+",
                   "min":87,
                   "max":89
                },
                {
                   "letter":"B",
                   "min":83,
                   "max":86
                },
                {
                   "letter":"B-",
                   "min":80,
                   "max":82
                },{
                   "letter":"C+",
                   "min":77,
                   "max":79
                },{
                   "letter":"C",
                   "min":73,
                   "max":76
                },{
                   "letter":"C-",
                   "min":70,
                   "max":72
                },{
                   "letter":"D+",
                   "min":67,
                   "max":69
                },{
                   "letter":"D",
                   "min":65,
                   "max":66
                },{
                   "letter":"D-",
                   "min":60,
                   "max":65
                },{
                   "letter":"F",
                   "min":0,
                   "max":60
                }
             ]'
        ]);
        DB::table('configs')->insert([
            'key'=>'certificates',
            'value'=>'[{
                "value": "C1",
                "label": "服務獎",
                "category": null
            }, {
                "value": "C2",
                "label": "風紀服務獎",
                "category": [{
                    "value": "C2-1",
                    "label": "隊長"
                }, {
                    "value": "C2-2",
                    "label": "副隊長"
                }, {
                    "value": "C2-3",
                    "label": "隊員"
                }]
            }, {
                "value": "C3",
                "label": "領袖生服務獎",
                "category": null
            }, {
                "value": "C4",
                "label": "操行獎",
                "category": null
            }, {
                "value": "C5",
                "label": "學業獎",
                "category": [{
                    "value": "C5-1",
                    "label": "壹"
                }, {
                    "value": "C5-2",
                    "label": "貳"
                }, {
                    "value": "C5-3",
                    "label": "叁"
                }, {
                    "value": "C5-4",
                    "label": "肆"
                }, {
                    "value": "C5-5",
                    "label": "伍"
                }]
            }, {
                "value": "C6",
                "label": "循序獎",
                "category": null
            }, {
                "value": "C7",
                "label": "學生自治會服務獎",
                "category": [{
                    "value": "C7-1",
                    "label": "會長"
                }, {
                    "value": "C7-2",
                    "label": "副會長"
                }, {
                    "value": "C7-3",
                    "label": "幹事"
                }]
            }, {
                "value": "C8",
                "label": "飛躍進步獎",
                "category": null
            }]'
        ]);
        DB::table('configs')->insert([
            'key'=>'additive_style',
            'value'=>'"default"',
            'remark'=>'"default","direct","page"'
        ]);

        DB::table('configs')->insert([
            'key'=>'additive_groups',
            'value'=>'[
                {
                    "category": "POSITIVE",
                    "label": "正向行為"
                },{
                    "category": "NEGATIVE",
                    "label": "負向行為"
                },{
                    "category": "PARTICIPATION",
                    "label": "參與參與行為"
                },{
                    "category": "COMMENT",
                    "label": "評語"
                }
            ]'
        ]);

        DB::table('configs')->insert([
            'key'=>'topic_abilities',
            'value'=>'[{
                "value":"health",
                "label":"健康與體育"
                },{
                "value":"language",
                "label":"語言"
                },{
                "value":"social",
                "label":"個人、社會與人文"
                },{
                "value":"science",
                "label":"數學與科學"
                },{
                "value":"art",
                "label":"藝術"                
            }]'
        ]);

        DB::table('configs')->insert([
            'key'=>'medical_treatments',
            'value'=>'[{
                "value":"DISCOMFORT",
                "label":"身體不適"
                },{
                "value":"TRAUMA",
                "label":"普通外傷"
                },{
                "value":"REST",
                "label":"卧床休息"
                },{
                "value":"ACCIDENT",
                "label":"嚴重意外"
            }]'
        ]);

        DB::table('configs')->insert([
            'key'=>'bodycheck_columns',
            'value'=>'[
                {"label":"身高","value":"height"},
                {"label":"體重","value":"weight"},
                {"label":"BMI","value":"bmi"},
                {"label":"脊椎側彎","value":"spinal"},
                {"label":"心率","value":"heart"},
                {"label":"視力(左)","value":"eye_left"},
                {"label":"視力(右)","value":"eye_right"},
                {"label":"牙齿","value":"tooth"}
            ]'
        ]);

        DB::table('configs')->insert([
            'key'=>'issue_categories',
            'value'=>'[
                {"label":"系統維護管理","value":"master"},
                {"label":"行政管理","value":"admin"},
                {"label":"教務","value":"pedagogy"},
                {"label":"老師","value":"teacher"},
                {"label":"醫護","value":"medical"},
                {"label":"社工","value":"socialwork"}
            ]'
        ]);

        DB::table('configs')->insert([
            'key' => 'nations',
            'value' => '[
                {"id": "1", "nation": "1", "name_c": "葡國", "name_p": "PORTUGUESA"},
                {"id": "2", "nation": "2", "name_c": "中國", "name_p": "CHINESA"},
                {"id": "3", "nation": "3", "name_c": "英國", "name_p": "INGLESA"},
                {"id": "4", "nation": "4", "name_c": "美國", "name_p": "ESTADOS UNIDOS"},
                {"id": "5", "nation": "5", "name_c": "菲律賓", "name_p": "FILIPINA"},
                {"id": "6", "nation": "6", "name_c": "加拿大", "name_p": "CANADA"},
                {"id": "7", "nation": "7", "name_c": "緬甸", "name_p": "BIRMANIA"},
                {"id": "8", "nation": "8", "name_c": "泰國", "name_p": "TAILANDIA"},
                {"id": "9", "nation": "9", "name_c": "哥斯達黎加", "name_p": "COSTA RICA"},
                {"id": "10", "nation": "10", "name_c": "東加王國", "name_p": "TONGA"},
                {"id": "11", "nation": "11", "name_c": "委內瑞拉", "name_p": "VENEZUELA"},
                {"id": "12", "nation": "12", "name_c": "澳洲", "name_p": "AUSTRALIA"},
                {"id": "13", "nation": "13", "name_c": "日本", "name_p": "JAPAO"},
                {"id": "14", "nation": "14", "name_c": "韓國", "name_p": "COREIA DO SUL"},
                {"id": "15", "nation": "15", "name_c": "祕魯", "name_p": "PERU"},
                {"id": "16", "nation": "16", "name_c": "印度", "name_p": "INDIA"},
                {"id": "17", "nation": "17", "name_c": "洪都拉斯", "name_p": "HONDURAS"},
                {"id": "18", "nation": "18", "name_c": "多明尼加共", "name_p": "REPUBLICA DOMINICANA"},
                {"id": "19", "nation": "19", "name_c": "多米尼克", "name_p": "DOMINICA"},
                {"id": "20", "nation": "20", "name_c": "馬來西亞", "name_p": "MALASIA"},
                {"id": "21", "nation": "21", "name_c": "巴西", "name_p": "BRASIL"},
                {"id": "22", "nation": "22", "name_c": "印尼", "name_p": "INDONESIA"},
                {"id": "23", "nation": "23", "name_c": "馬達加斯加", "name_p": "MADAGASCAR"},
                {"id": "24", "nation": "24", "name_c": "塞拉里昂", "name_p": "SERRA LEONA"},
                {"id": "25", "nation": "25", "name_c": "紐西蘭", "name_p": "NOVA ZELANDIA"},
                {"id": "26", "nation": "26", "name_c": "法國", "name_p": "FRANCA"},
                {"id": "27", "nation": "27", "name_c": "斯里蘭卡", "name_p": "SRI LANKA"},
                {"id": "28", "nation": "28", "name_c": "愛爾蘭", "name_p": "IRLANDA"},
                {"id": "29", "nation": "29", "name_c": "厄瓜多爾", "name_p": "EQUADOR"},
                {"id": "30", "nation": "30", "name_c": "伯利茲", "name_p": "BELIZE"},
                {"id": "31", "nation": "31", "name_c": "德國", "name_p": "ALEMANHA"},
                {"id": "32", "nation": "32", "name_c": "新加坡", "name_p": "SINGAPURA"},
                {"id": "33", "nation": "33", "name_c": "巴拿馬", "name_p": "PANAMA"},
                {"id": "34", "nation": "34", "name_c": "毛里求斯", "name_p": "MAURICIAS"},
                {"id": "35", "nation": "35", "name_c": "尼加拉瓜", "name_p": "NICARAGUA"},
                {"id": "36", "nation": "36", "name_c": "危地馬拉", "name_p": "GUATEMALA"},
                {"id": "37", "nation": "37", "name_c": "西班牙", "name_p": "ESPANHA"},
                {"id": "38", "nation": "38", "name_c": "坦桑尼亞", "name_p": "TANZANIA"},
                {"id": "39", "nation": "39", "name_c": "莫桑比克", "name_p": "MOCAMBIQUE"},
                {"id": "40", "nation": "40", "name_c": "斐濟", "name_p": "FIJI"},
                {"id": "41", "nation": "41", "name_c": "朝鮮", "name_p": "COREIA"},
                {"id": "42", "nation": "42", "name_c": "奧地利", "name_p": "AUSTRIA"},
                {"id": "43", "nation": "43", "name_c": "阿根廷", "name_p": "ARGENTINA"},
                {"id": "44", "nation": "44", "name_c": "南非", "name_p": "AFRICA DO SUL"},
                {"id": "45", "nation": "45", "name_c": "玻利維亞", "name_p": "BOLIVIA"},
                {"id": "46", "nation": "46", "name_c": "埃及", "name_p": "EGIPTO"},
                {"id": "47", "nation": "47", "name_c": "挪威", "name_p": "NORUEGA"},
                {"id": "48", "nation": "48", "name_c": "瑞士", "name_p": "SUICA"},
                {"id": "49", "nation": "49", "name_c": "瑞典", "name_p": "SUECIA"},
                {"id": "50", "nation": "50", "name_c": "巴布亞新畿", "name_p": "PAPUA NOVA GUINE"},
                {"id": "51", "nation": "51", "name_c": "烏干達", "name_p": "UGANDA"},
                {"id": "52", "nation": "52", "name_c": "墨西哥", "name_p": "MEXICO"},
                {"id": "53", "nation": "53", "name_c": "意大利", "name_p": "ITALY"},
                {"id": "54", "nation": "54", "name_c": "巴基斯坦", "name_p": "PAKISTAN"},
                {"id": "55", "nation": "55", "name_c": "塞席爾", "name_p": "SEYCHEUES"},
                {"id": "56", "nation": "56", "name_c": "古巴", "name_p": "CUBA"},
                {"id": "57", "nation": "57", "name_c": "瑞典", "name_p": "SWEDEN"},
                {"id": "58", "nation": "58", "name_c": "馬耳他", "name_p": "MALTA"},
                {"id": "59", "nation": "59", "name_c": "比利時", "name_p": "BELGICA"},
                {"id": "60", "nation": "60", "name_c": "越南", "name_p": "VIETNAM"},
                {"id": "61", "nation": "61", "name_c": "奧地利", "name_p": "Austria"},
                {"id": "62", "nation": "62", "name_c": "荷蘭", "name_p": "Holanda"},
                {"id": "63", "nation": "63", "name_c": "聖露西亞", "name_p": "St. Lucia"},
                {"id": "64", "nation": "64", "name_c": "丹麥", "name_p": "Dinamarca"},
                {"id": "65", "nation": "65", "name_c": "柬埔寨", "name_p": "Camboja"},
                {"id": "66", "nation": "66", "name_c": "千里達", "name_p": "Trindade"},
                {"id": "67", "nation": "67", "name_c": "烏拉圭", "name_p": "Uraguay"},
                {"id": "68", "nation": "68", "name_c": "波蘭", "name_p": "Polandesa"},
                {"id": "69", "nation": "69", "name_c": "幾內亞比紹", "name_p": "Guine Basseu"},
                {"id": "70", "nation": "70", "name_c": "安哥拉", "name_p": "Angolense"},
                {"id": "71", "nation": "71", "name_c": "俄羅斯", "name_p": "Russo"},
                {"id": "72", "nation": "72", "name_c": "南斯拉夫", "name_p": "Jugoslav"},
                {"id": "73", "nation": "73", "name_c": "哥倫比亞", "name_p": "Columbia"},
                {"id": "74", "nation": "74", "name_c": "智利", "name_p": "CHILE"},
                {"id": "75", "nation": "75", "name_c": "匈牙利", "name_p": "Hungria"},
                {"id": "76", "nation": "76", "name_c": "西薩摩亞", "name_p": "Samoa Ocidental"},
                {"id": "77", "nation": "77", "name_c": "岡比亞", "name_p": "Gambia"},
                {"id": "78", "nation": "78", "name_c": "諾魯/瑙魯", "name_p": "Nauru"},
                {"id": "79", "nation": "79", "name_c": "聖多美和林西比", "name_p": "S緌 Tom e Principe"},
                {"id": "80", "nation": "80", "name_c": "基里巴斯", "name_p": "Kiribati"},
                {"id": "81", "nation": "81", "name_c": "尼泊爾", "name_p": "Napel"},
                {"id": "82", "nation": "82", "name_c": "牙買加", "name_p": "Jamaica"},
                {"id": "83", "nation": "83", "name_c": "芬蘭", "name_p": "Finland"},
                {"id": "84", "nation": "84", "name_c": "保加利亞", "name_p": "Bugarlia"},
                {"id": "85", "nation": "85", "name_c": "土耳其", "name_p": "Turkia"},
                {"id": "86", "nation": "86", "name_c": "尼日利亞", "name_p": "NIGERIA"},
                {"id": "87", "nation": "87", "name_c": "阿拉伯聯合酋長國", "name_p": "Arabes Unidos (Estados dos Emirados)"},
                {"id": "88", "nation": "88", "name_c": "多哥", "name_p": "Togo"},
                {"id": "89", "nation": "89", "name_c": "羅馬尼亞", "name_p": "ROMENO"},
                {"id": "90", "nation": "90", "name_c": "亞美尼亞", "name_p": "REPUBLIC OF ARMENIA"},
                {"id": "91", "nation": "91", "name_c": "杜拜", "name_p": "DUBAI"},
                {"id": "92", "nation": "92", "name_c": "馬爾代夫", "name_p": "Maldivas"},
                {"id": "93", "nation": "93", "name_c": "希臘", "name_p": "Hellenic"},
                {"id": "94", "nation": "94", "name_c": "烏克蘭", "name_p": "Ukrainian"},
                {"id": "95", "nation": "95", "name_c": "敘利亞", "name_p": "Siria"},
                {"id": "96", "nation": "96", "name_c": "馬紹爾群島", "name_p": "MARSHALL ISLANDS"},
                {"id": "97", "nation": "97", "name_c": "捷克", "name_p": "CZECH REPUBLIC"},
                {"id": "98", "nation": "999", "name_c": "不詳", "name_p": "INCONHECIDO"}
            ]'
        ]);
        
        DB::table('configs')->insert([
            'key' => 'places',
            'value' => '[
                {"id": "1", "place": "1", "name_c": "澳門", "name_p": "MACAU"},
                {"id": "2", "place": "2", "name_c": "內地", "name_p": "CHINA CONTINENTAL"},
                {"id": "3", "place": "3", "name_c": "葡國", "name_p": "PORTUGAL"},
                {"id": "4", "place": "4", "name_c": "香港", "name_p": "HONG KONG"},
                {"id": "5", "place": "5", "name_c": "美國", "name_p": "ESTADOS UNIDOS"},
                {"id": "6", "place": "6", "name_c": "緬甸", "name_p": "BIRMANIA"},
                {"id": "7", "place": "7", "name_c": "菲律賓", "name_p": "FILIPINA"},
                {"id": "8", "place": "8", "name_c": "加拿大", "name_p": "CANADA"},
                {"id": "9", "place": "9", "name_c": "泰國", "name_p": "TAILANDIA"},
                {"id": "10", "place": "10", "name_c": "巴西", "name_p": "BRASIL"},
                {"id": "11", "place": "11", "name_c": "哥斯達黎加", "name_p": "COSTA RICA"},
                {"id": "12", "place": "12", "name_c": "澳洲", "name_p": "AUSTRALIA"},
                {"id": "13", "place": "13", "name_c": "委內瑞拉", "name_p": "VENEZUELA"},
                {"id": "14", "place": "14", "name_c": "莫桑比克", "name_p": "MOCAMBIQUE"},
                {"id": "15", "place": "15", "name_c": "馬達加斯加", "name_p": "MADAGASCAR"},
                {"id": "16", "place": "16", "name_c": "英國", "name_p": "INGLATERRA"},
                {"id": "17", "place": "17", "name_c": "秘魯", "name_p": "PERU"},
                {"id": "18", "place": "18", "name_c": "韓國", "name_p": "COREIA DO SUL"},
                {"id": "19", "place": "19", "name_c": "印尼", "name_p": "INDONESIA"},
                {"id": "20", "place": "20", "name_c": "安哥拉", "name_p": "ANGOLA"},
                {"id": "21", "place": "21", "name_c": "馬來西亞", "name_p": "MALASIA"},
                {"id": "22", "place": "22", "name_c": "日本", "name_p": "JAPAO"},
                {"id": "23", "place": "23", "name_c": "愛爾蘭", "name_p": "IRLANDA"},
                {"id": "24", "place": "24", "name_c": "印度", "name_p": "INDIA"},
                {"id": "25", "place": "25", "name_c": "法國", "name_p": "FRANCA"},
                {"id": "26", "place": "26", "name_c": "新加坡", "name_p": "SINGAPURA"},
                {"id": "27", "place": "27", "name_c": "多明尼加", "name_p": "REPUBLICA DOMINICANA"},
                {"id": "28", "place": "28", "name_c": "多米尼克", "name_p": "DOMINICA"},
                {"id": "29", "place": "29", "name_c": "哥倫比亞", "name_p": "COLOMBIA"},
                {"id": "30", "place": "30", "name_c": "斯里蘭卡", "name_p": "SRI LANKA"},
                {"id": "31", "place": "31", "name_c": "巴拿馬", "name_p": "PANAMA"},
                {"id": "32", "place": "32", "name_c": "毛里求斯", "name_p": "MAURICIAS"},
                {"id": "33", "place": "33", "name_c": "尼加拉瓜", "name_p": "NICARAGUA"},
                {"id": "34", "place": "34", "name_c": "南非", "name_p": "AFRICA DO SUL"},
                {"id": "35", "place": "35", "name_c": "紐西蘭", "name_p": "NOVA ZELANDIA"},
                {"id": "36", "place": "36", "name_c": "東加王國", "name_p": "TONGA"},
                {"id": "37", "place": "37", "name_c": "厄瓜多爾", "name_p": "EQUADOR"},
                {"id": "38", "place": "38", "name_c": "危地馬拉", "name_p": "GUATEMALA"},
                {"id": "39", "place": "39", "name_c": "老撾", "name_p": "LAOS"},
                {"id": "40", "place": "40", "name_c": "洪都拉斯", "name_p": "HONDURAS"},
                {"id": "41", "place": "41", "name_c": "斐濟", "name_p": "FIJI"},
                {"id": "42", "place": "42", "name_c": "德國", "name_p": "ALEMANHA"},
                {"id": "43", "place": "43", "name_c": "坦桑尼亞", "name_p": "TANZANIA"},
                {"id": "44", "place": "44", "name_c": "柬埔寨", "name_p": "CAMBOJA"},
                {"id": "45", "place": "45", "name_c": "海上", "name_p": "NO MAR"},
                {"id": "46", "place": "46", "name_c": "利比里亞", "name_p": "LIBERIA"},
                {"id": "47", "place": "47", "name_c": "千里達", "name_p": "TRINDADE"},
                {"id": "48", "place": "48", "name_c": "西班牙", "name_p": "ESPANHA"},
                {"id": "49", "place": "49", "name_c": "伯利茲", "name_p": "BELIZE"},
                {"id": "50", "place": "50", "name_c": "阿根廷", "name_p": "ARGENTINA"},
                {"id": "51", "place": "51", "name_c": "玻利維亞", "name_p": "BOLIVIA"},
                {"id": "52", "place": "52", "name_c": "埃及", "name_p": "EGIPTO"},
                {"id": "53", "place": "53", "name_c": "荷蘭", "name_p": "HOLANDA"},
                {"id": "54", "place": "54", "name_c": "朝鮮", "name_p": "COREIA"},
                {"id": "55", "place": "55", "name_c": "越南", "name_p": "VIETNAME"},
                {"id": "56", "place": "56", "name_c": "意大利", "name_p": "ITALIA"},
                {"id": "57", "place": "57", "name_c": "薩爾瓦多", "name_p": "SALVADOR"},
                {"id": "58", "place": "58", "name_c": "俄羅斯", "name_p": "RUSSIA"},
                {"id": "59", "place": "59", "name_c": "新畿內亞", "name_p": "PAPUA NOVA GUINE"},
                {"id": "60", "place": "60", "name_c": "烏干達", "name_p": "UGANDA"},
                {"id": "61", "place": "61", "name_c": "墨西哥", "name_p": "MEXICO"},
                {"id": "62", "place": "62", "name_c": "東非", "name_p": "E. AFRICA"},
                {"id": "63", "place": "63", "name_c": "塞席爾", "name_p": "SEYCHEUES"},
                {"id": "64", "place": "64", "name_c": "伊朗", "name_p": "IRAN"},
                {"id": "65", "place": "65", "name_c": "中國臺灣", "name_p": "TAIWAN, CHINA"},
                {"id": "66", "place": "66", "name_c": "巴基斯坦", "name_p": "PAKISTAN"},
                {"id": "67", "place": "67", "name_c": "巴林", "name_p": "BAHRAIN"},
                {"id": "68", "place": "68", "name_c": "古巴", "name_p": "CUBA"},
                {"id": "69", "place": "69", "name_c": "瑞典", "name_p": "SWEDEN"},
                {"id": "70", "place": "70", "name_c": "馬耳他", "name_p": "MALTA"},
                {"id": "71", "place": "71", "name_c": "比利時", "name_p": "BELGICA"},
                {"id": "72", "place": "72", "name_c": "奧地利", "name_p": "Austria"},
                {"id": "73", "place": "73", "name_c": "東帝汶", "name_p": "Timor"},
                {"id": "74", "place": "74", "name_c": "幾內亞比紹", "name_p": "Guine Basseu"},
                {"id": "75", "place": "75", "name_c": "挪威", "name_p": "Noruega"},
                {"id": "76", "place": "76", "name_c": "聖露西亞", "name_p": "St. Lucia"},
                {"id": "77", "place": "77", "name_c": "丹麥", "name_p": "Dinamarca"},
                {"id": "78", "place": "78", "name_c": "烏拉圭", "name_p": "Uruguay"},
                {"id": "79", "place": "79", "name_c": "瑞士", "name_p": "Suica"},
                {"id": "80", "place": "80", "name_c": "波蘭", "name_p": "Polanda"},
                {"id": "81", "place": "81", "name_c": "格林納達", "name_p": "Grandola"},
                {"id": "82", "place": "82", "name_c": "南斯拉夫", "name_p": "Jugoslavia"},
                {"id": "83", "place": "83", "name_c": "智利", "name_p": "CHILE"},
                {"id": "84", "place": "84", "name_c": "突尼斯", "name_p": "Tnis"},
                {"id": "85", "place": "85", "name_c": "諾魯/瑙魯", "name_p": "Nauru"},
                {"id": "86", "place": "96", "name_c": "佛得角", "name_p": "Cabo Verde"},
                {"id": "87", "place": "97", "name_c": "聖多美和林西比", "name_p": "S緌 Tom e Principe"},
                {"id": "88", "place": "98", "name_c": "尼泊爾", "name_p": "Napel"},
                {"id": "89", "place": "99", "name_c": "匈牙利", "name_p": "HUNGRIA"},
                {"id": "90", "place": "100", "name_c": "牙買加", "name_p": "Jamaica"},
                {"id": "91", "place": "101", "name_c": "芬蘭", "name_p": "Finland"},
                {"id": "92", "place": "102", "name_c": "保加利亞", "name_p": "Bugarlia"},
                {"id": "93", "place": "103", "name_c": "土耳其", "name_p": "Turkia"},
                {"id": "94", "place": "104", "name_c": "尼日利亞", "name_p": "NIGERIA"},
                {"id": "95", "place": "105", "name_c": "阿拉伯聯合酋長國", "name_p": "Arabes Unidos (Estados dos Emirados)"},
                {"id": "96", "place": "106", "name_c": "多哥", "name_p": "Togo"},
                {"id": "97", "place": "107", "name_c": "羅馬尼亞", "name_p": "ROM冇IA"},
                {"id": "98", "place": "108", "name_c": "烏克蘭", "name_p": "Ucr滱ia"},
                {"id": "99", "place": "109", "name_c": "希臘", "name_p": "GREケCIAケ"},
                {"id": "100", "place": "110", "name_c": "亞美尼亞", "name_p": "REPUBLIC OF ARMENIA"},
                {"id": "101", "place": "111", "name_c": "杜拜", "name_p": "DUBAI"},
                {"id": "102", "place": "112", "name_c": "馬爾代夫", "name_p": "Maldivas"},
                {"id": "103", "place": "113", "name_c": "敘利亞", "name_p": "Siria"},
                {"id": "104", "place": "114", "name_c": "馬紹爾群島", "name_p": "MARSHALL ISLANDS"},
                {"id": "105", "place": "115", "name_c": "馬朱羅", "name_p": "MAJURO"},
                {"id": "106", "place": "116", "name_c": "捷克", "name_p": "CZECH REPUBLIC"},
                {"id": "107", "place": "999", "name_c": "不詳", "name_p": "INCONHECIDO"}
            ]'
        ]);

        DB::table('configs')->insert([
            'key' => 'id_list',
            'value' => '[
                {"id": "8", "id_type": "BIR", "name_c": "澳門居民身份證", "name_p": "BILHETE DE IDENTIDADE DE RESIDENTE DE MACAU"},
                {"id": "9", "id_type": "BIRNP", "name_c": "非永久性居民身份證", "name_p": "Bilhete de identidade de residente n緌 permanente"},
                {"id": "10", "id_type": "BIRP", "name_c": "永久性居民身份證", "name_p": " Bilhete de identidade de residente permanente"},
                {"id": "3", "id_type": "ADN", "name_c": "澳門出生登記", "name_p": "ASSENTO DE NASCIMENTO"},
                {"id": "4", "id_type": "BIC", "name_c": "領事身份證", "name_p": "Billhete de Identidade Consular"},
                {"id": "5", "id_type": "BICHN", "name_c": "中國居民身份證", "name_p": "Bilhelte de Identidade da RPC"},
                {"id": "6", "id_type": "BIE", "name_c": "非葡藉認別證", "name_p": "BILHETE DE IDENTIDADE DE CIDADAO ESTRANGEIRO"},
                {"id": "7", "id_type": "BIN", "name_c": "葡藉認別證", "name_p": "BILHETE DE IDENTIDADE DE CIDADAO NACIONAL"},
                {"id": "11", "id_type": "CEDUL", "name_c": "葡國中央登記", "name_p": "CEDULA PESSOAL"},
                {"id": "12", "id_type": "CI", "name_c": "簽證身份書", "name_p": "Document of Identity for Visa Purpose"},
                {"id": "13", "id_type": "CIP", "name_c": "澳門身份證", "name_p": "CEDULA DE IDENTIFICACAO POLICIAL"},
                {"id": "14", "id_type": "COB", "name_c": "香港出生登記", "name_p": "CERTIFICATE OF BIRTH"},
                {"id": "15", "id_type": "CPAS", "name_c": "中國護照", "name_p": "PASSPORTE CHINES"},
                {"id": "16", "id_type": "CPASS", "name_c": "中國通行証", "name_p": "SALVO-CONDUTO DA CHINA"},
                {"id": "17", "id_type": "HKID", "name_c": "香港身份證", "name_p": "HONG KONG IDENTITY CARD"},
                {"id": "18", "id_type": "HKPAS", "name_c": "香港特區護照", "name_p": "HKSAR passport"},
                {"id": "19", "id_type": "HKREP", "name_c": "回港証", "name_p": "RE-ENTRY PERMIT"},
                {"id": "20", "id_type": "PAS", "name_c": "外國護照", "name_p": "PASSPORTE"},
                {"id": "21", "id_type": "PPAS", "name_c": "葡國護照", "name_p": "PASSPORTE PORTUGUES"},
                {"id": "22", "id_type": "RECIB", "name_c": "移民局收條", "name_p": "RECIBO"},
                {"id": "23", "id_type": "TITNR", "name_c": "非本地勞工身份咭", "name_p": "TITULO DE IDENTIFICACAO DE TRABALHADOR NAO-RESIDENTE"},
                {"id": "24", "id_type": "TNR", "name_c": "外地僱員身份認別證", "name_p": "TITULO DE IDENTIFICACAO DE TRABALHADOR NAO-RESIDENTE"},
                {"id": "25", "id_type": "TPT", "name_c": "臨時逗留證", "name_p": "TITULO DE PERMANENCIA TEMPORARIA"},
                {"id": "26", "id_type": "TRP", "name_c": "永久居留證", "name_p": "TITULO DE RESIDENCIA (PERMANENTE)"},
                {"id": "27", "id_type": "TRT", "name_c": "臨時居留證", "name_p": "TITULO DE RESIDENCIA (TEMPORARIO)"},
                {"id": "1", "id_type": "", "name_c": "空", "name_p": "Vazio"},
                {"id": "2", "id_type": "*", "name_c": "*", "name_p": "NULO"}
            ]'
        ]);

        DB::table('configs')->insert([
            'key' => 'areas',
            'value' => '[
                {"id": "1", "area": "M", "name_c": "澳門", "name_p": "Macau"},  
                {"id": "2", "area": "T", "name_c": "氹仔", "name_p": "Taipa"},
                {"id": "3", "area": "C", "name_c": "路環", "name_p": "Colone"},
                {"id": "4", "area": "ZH", "name_c": "珠海", "name_p": "ZhuHai"},
                {"id": "5", "area": "ZS", "name_c": "中山", "name_p": "ZhongShan"},
                {"id": "6", "area": "O", "name_c": "其他", "name_p": "Others"}
            ]'
        ]);
    }
}

/*
topic_abilities=
[{
"value":"health",
"label":"健康與體育"
},
{
"value":"language",
"label":"語言"
},
{
"value":"social",
"label":"個人、社會與人文"
},{
"value":"science",
"label":"數學與科學"
},{
"value":"art",
"label":"藝術"
}]
*/