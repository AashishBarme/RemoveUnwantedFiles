$scriptDir = Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent
$jsonPath =  Join-Path -Path $scriptDir -ChildPath 'settings.json'
$json = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json


$fileNames = Import-Csv -Path $json.CsvFilePath  | Select-Object -Property FileName
$filePath = $json.RemovingFilesLocation

$csvFileNames = New-Object Collections.Generic.List[String]

foreach($x in $fileNames)
{
    $csvFileNames.Add($x.FileName)
}

Write-Host "Total Name in CSV:" $csvFileNames.Count

Write-Host  "Total Files:"(Get-ChildItem $filePath | Measure-Object).Count


if((Get-Item $filePath) -is [System.IO.DirectoryInfo]){
	foreach($fileName in Get-ChildItem $filePath)
    {
        $currentFile =  $fileName.Name.Replace(".pdbqt", "")
        if(!$csvFileNames.Contains($currentFile))
        {
            $currentFilePath = $filePath + "\" + $currentFile + ".pdbqt"
            Remove-Item -Path $currentFilePath 
            Write-Host "Removed File:"$currentFilePath -f red  
        }
        $i++
	}
}