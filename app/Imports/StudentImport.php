<?php

namespace App\Imports;

use App\Models\Student;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\SkipsFailures;
use Maatwebsite\Excel\Concerns\WithStartRow;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\SkipsEmptyRows;

class StudentImport implements ToModel, WithStartRow ,WithValidation, SkipsOnFailure,WithHeadingRow,SkipsEmptyRows
{   protected $importedRows=[];
    use Importable, SkipsFailures;
    
    function __construct()
    {
    }
    public function headingRow(): int
    {
        return 2;
    }
    public function startRow(): int
    {
        return 4;
    }
   
    public function model(array $row)
    {   $this->importedRows[]=$row;
        $insertObj=[];
        $relationObj=['mother'=>'MOTHER','father'=>'FATHER','guardian'=>"GUARDIAN"];
        foreach($row as $key=>$value){
            $key_arr=explode('-',$key);
            $tableKey=$key_arr[0];
            $tableColKey=$key_arr[1];
            if(!isset($insertObj[$tableKey])){
                $insertObj[$tableKey]=[];
            }
            if($tableKey==='relatives'){ // relatives-father-name 
                $kindShip=$key_arr[1]; // e.g:father
                $tableColKey=$key_arr[2];//e.g: name_zh
                if(!isset($insertObj[$tableKey][$kindShip])){
                    $insertObj[$tableKey][$kindShip]=['relation'=>$relationObj[$kindShip]??'GUARDIAN'];
                }
                $insertObj[$tableKey][$kindShip][$tableColKey]=$value;
                continue;
            }
            $insertObj[$tableKey][$tableColKey]=$value;
        }
        $student = New Student( $insertObj['students']);
        $student->save();
        foreach($insertObj['relatives'] as $kindShipObj){
            $student->relatives()->updateOrCreate(['relation'=>$kindShipObj['relation']],$kindShipObj);
        }
        return $student; 

    }
    public function rules(): array
    {
        return [
            'students-name_c'=>'required',
            'students-id_no' => 'required',
            // 'students-dob'=>'date',
            // 'students-entry_date'=>'date',  
            // 'students-id_num'=>'required|unique:students,id_num'
        ];
    }
    public function getImportedRow(): array{
        return $this->importedRows;
    }
    

}
