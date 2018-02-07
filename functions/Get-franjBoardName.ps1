$uriroot = 'http://franjiban.fs.fujitsu.com/api/get'
$headers = New-Object -TypeName 'System.Collections.Generic.Dictionary[[String],[String]]'

function get-FranjBoardName {
  <#
      .SYNOPSIS
      Gets the Franjiban boards accessible to the user

      .DESCRIPTION
      Gets the Franjiban boards accessible to the user, based on the token supplied.

      .EXAMPLE
      get-FranjBoardName
      returns a list of franjiban board names, as a pscustom object. to return as an array of strings:
      (get-franjboardnames).boardname



      .INPUTS
      none

      .OUTPUTS
      pscustom object containing a list of boardnames
  #>


  [cmdletBinding()]
  Param()
  test-token
  $uri = ('{0}/?query=board' -f $uriroot)
  $headers.Remove('X-AUTH-TOKEN') *>$null
  $headers.Add('X-AUTH-TOKEN',('{0}' -f $script:token))
  Invoke-RestMethod -Uri $uri -Headers $headers |
  Select-Object -expand data 
}