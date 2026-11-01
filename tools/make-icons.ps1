# Generates placeholder PNG icons into ../icons.
# Replace the files in icons/ with your own artwork any time (keep the same names and sizes).
Add-Type -AssemblyName System.Drawing

$outDir = Join-Path $PSScriptRoot "..\icons"
New-Item -ItemType Directory -Force $outDir | Out-Null

function New-Icon([int]$size, [string]$file, [double]$padding) {
    $bmp = New-Object System.Drawing.Bitmap $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = "AntiAlias"
    $g.TextRenderingHint = "AntiAliasGridFit"

    # Full-bleed gradient background (iOS and Android apply their own rounded mask).
    $rect = New-Object System.Drawing.Rectangle 0, 0, $size, $size
    $bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, `
        ([System.Drawing.Color]::FromArgb(255, 239, 68, 68)), `
        ([System.Drawing.Color]::FromArgb(255, 124, 58, 237)), 45
    $g.FillRectangle($bg, $rect)

    # "HP" monogram, kept inside the safe zone.
    $inner = $size * (1 - 2 * $padding)
    $font = New-Object System.Drawing.Font "Segoe UI", ([float]($inner * 0.42)), ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
    $fmt = New-Object System.Drawing.StringFormat
    $fmt.Alignment = "Center"
    $fmt.LineAlignment = "Center"
    $textRect = New-Object System.Drawing.RectangleF 0, 0, $size, $size
    $g.DrawString("HP", $font, [System.Drawing.Brushes]::White, $textRect, $fmt)

    $bmp.Save((Join-Path $outDir $file), [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
}

New-Icon 192 "icon-192.png" 0.10
New-Icon 512 "icon-512.png" 0.10
New-Icon 512 "icon-maskable-512.png" 0.20
New-Icon 180 "apple-touch-icon.png" 0.10
Write-Output "Icons written to $outDir"
