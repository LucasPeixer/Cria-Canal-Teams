$projeto = ""
$grupo = ""

# Substitui todos os caracteres que não são letras, números ou espaços por uma string vazia
function Remove-CaracterEspecial {
  param (
    [string]$Entrada
  )
  $Refatorado = $Entrada -replace '[^a-zA-Z0-9\s]', ''
  return $Refatorado -replace '\s+', ''
}

#Importando Teams
try {
  Write-Host "Importando o modulo Teams"
  Import-Module MicrosoftTeams
  Write-Host "OK!"
}
catch {
  Write-Host "Erro ao importar, instalando o Modulo"
  Install-Module MicrosoftTeams
  Write-Host "OK!"
}
finally {
  Write-Host "Conectando ao Teams!"
  Connect-MicrosoftTeams
  Write-Host "OK!"
}

# Solicita o nome do projeto
while ($projeto -eq "") {
  $projeto = Read-Host -Prompt "Digite o nome do projeto"
  $projeto = Remove-CaracterEspecial -Entrada $projeto
  Write-Host "Ok!"
}

While ($grupo -eq "") {
  $grupo = Read-Host -Prompt "Informe o grupo que deseja criar o canal"
  Write-Host "OK"
}

# Verificando se o time já existe
$verificaGrupo = Get-Team -DisplayName $grupo -ErrorAction SilentlyContinue

if ($null -eq $verificaGrupo) {
  Write-Host "A equipe não existe."
  return;
}
else { 
  New-TeamChannel -GroupId $verificaGrupo.GroupId -DisplayName "$projeto" -MembershipType Private
  Write-Host "OK!"
}
