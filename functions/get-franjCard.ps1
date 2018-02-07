$uriroot = 'http://franjiban.fs.fujitsu.com/api/get'
$headers = New-Object -TypeName 'System.Collections.Generic.Dictionary[[String],[String]]'

function get-Franjcard {
  <#
      .SYNOPSIS
      Describe purpose of "get-Franjcards" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      get-Franjcards
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online get-Franjcards

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>


  [cmdletBinding()]
  Param()
  test-token
  $uri = ('{0}/?query=card' -f $uriroot)
   $headers.Remove('X-AUTH-TOKEN') *>$null
  $headers.Add('X-AUTH-TOKEN',('{0}' -f $script:token))
  Invoke-RestMethod -Uri $uri -Headers $headers |
  Select-Object -expand data 
}