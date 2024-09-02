$ifPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'flag.jpg')
$efPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'flag.enc')

$aes = New-Object System.Security.Cryptography.AesManaged
$aes.KeySize = 256
$aes.BlockSize = 128
$aes.GenerateKey()
$aes.GenerateIV()

$cee = [System.Convert]::ToBase64String($aes.Key)
$vee = [System.Convert]::ToBase64String($aes.IV)

$content = [System.IO.File]::ReadAllBytes($ifPath)
$encryptor = $aes.CreateEncryptor($aes.Key, $aes.IV)
$encryptedData = $encryptor.TransformFinalBlock($content, 0, $content.Length)
$encryptedBase64 = [System.Convert]::ToBase64String($encryptedData)

[System.IO.File]::WriteAllText($efPath, $encryptedBase64)

$cee
$vee

if (Test-Path $ifPath) {
    Remove-Item $ifPath -Force
}