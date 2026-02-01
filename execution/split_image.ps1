[void][Reflection.Assembly]::LoadWithPartialName('System.Drawing')
$imagePath = "x:\assorted\obsidian\assorted\links\tasks\(main)(website) k-church-project\html\images\RM_Website-018.jpg"

if (-not (Test-Path $imagePath)) {
    Write-Host "File not found: $imagePath"
    exit
}

$img = [System.Drawing.Image]::FromFile($imagePath)
$width = [int]$img.Width
$height = [int]$img.Height
$sliceWidth = [int][Math]::Floor($width / 3)

Write-Host "Image size: $width x $height"
Write-Host "Slice width: $sliceWidth"

for ($i = 0; $i -lt 3; $i++) {
    $x = [int]($i * $sliceWidth)
    Write-Host "Processing slice $i at x=$x"
    
    $rect = New-Object System.Drawing.Rectangle($x, 0, $sliceWidth, $height)
    $bmp = New-Object System.Drawing.Bitmap($sliceWidth, $height)
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)
    
    $destRect = New-Object System.Drawing.Rectangle(0, 0, $sliceWidth, $height)
    
    $graphics.DrawImage($img, $destRect, $rect, [System.Drawing.GraphicsUnit]::Pixel)
    
    $outputPath = "x:\assorted\obsidian\assorted\links\tasks\(main)(website) k-church-project\html\images\RM_Website-018_part$($i+1).jpg"
    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    
    $graphics.Dispose()
    $bmp.Dispose()
    Write-Host "Successfully saved $outputPath"
}

$img.Dispose()
