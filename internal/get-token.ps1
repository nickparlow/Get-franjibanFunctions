
function get-token {
  <#
      .SYNOPSIS
      Fetches a token from the MISToolsets endpoint

      .DESCRIPTION
      This function checks if the user is logged on with G0x domain credentials, 
      and if not collects interactive G0x domain credentials from the user, 
      then supplies them securely to the MISToolsets endpoint. it collects the 
      return, extracts the token and attaches that to a script scoped variable
      for use elsewhere

      .EXAMPLE
      get-token
      populates the $script:token variable with a valid token

      .INPUTS
      none

      .OUTPUTS
      token held in a script variable
  #>
  $username = Get-WMIObject -class Win32_ComputerSystem | select username
  $usernameArray = (($username.username.trim('username=')).split('\'))
  if($usernameArray[0] -notcontains 'G0') {
    $cred = Get-Credential
    $script:token = ''
    $script:response = Invoke-WebRequest -Uri 'http://mistoolsets.emeia.fujitsu.local/auth/' -Credential $cred
  }
  else {
  $script:token = ''
    $script:response = Invoke-WebRequest -Uri 'http://mistoolsets.emeia.fujitsu.local/auth/' -UseDefaultCredentials
  }
   
  $script:token = $script:response.Headers.'X-Auth-Token' 
  #return $script:token
}

function test-token {
  <#
      .SYNOPSIS
      Checks for a valid token

      .DESCRIPTION
      checks that $scritp:token is populated with an unspired token. if it is not, then it calls get-token.

      .EXAMPLE
      test-token
      checks for valid token


    .INPUTS
    none

    .OUTPUTS
    none
  #>


if($script:token -ne $null) {  
  $mytoken = $script:response.Content | ConvertFrom-Json
  $now=[datetime](get-date)
  $mytokendate = [datetime]$mytoken.token.expires_at
  if($mytokendate -le $now) {
    get-token
  
  }
  }

else {get-token}

}