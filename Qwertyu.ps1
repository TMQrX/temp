$filePath = 'C:\flag.txt'

$aes = New-Object System.Security.Cryptography.AesManaged
$aes.KeySize = 256
$aes.BlockSize = 128
$aes.GenerateKey()
$aes.GenerateIV()

$cee = [System.Convert]::ToBase64String($aes.Key)
$vee = [System.Convert]::ToBase64String($aes.IV)

$content = [System.IO.File]::ReadAllBytes($filePath)

$encryptor = $aes.CreateEncryptor($aes.Key, $aes.IV)
$encryptedData = $encryptor.TransformFinalBlock($content, 0, $content.Length)

$encryptedBase64 = [System.Convert]::ToBase64String($encryptedData)

[System.IO.File]::WriteAllText($filePath, $encryptedBase64)

$cee
$vee
