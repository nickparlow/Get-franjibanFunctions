$uriroot = 'http://franjiban.fs.fujitsu.com/api/get'
$headers = New-Object -TypeName 'System.Collections.Generic.Dictionary[[String],[String]]'

function get-franjcardcomment {
  <#
      .SYNOPSIS
      Describe purpose of "get-franjcardcomments" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .PARAMETER cardid
      Describe parameter -cardid.

      .EXAMPLE
      get-franjcardcomment -cardid Value
      Describe what this call does

      .NOTES
      Place additional notes here.

    .LINK
    URLs to related sites
    The first link is opened by Get-Help -Online get-franjcardcomments

    .INPUTS
    List of input types that are accepted by this function.

    .OUTPUTS
    List of output types produced by this function.
  #>


  [cmdletBinding()]
  Param(
    [parameter(ValueFromPipeline,valuefrompipelinebypropertyname,Mandatory=$true,HelpMessage='you need to supply a Card ID. run "Get-FranjCards" to get one.')]
    [int32]$card_id
  )
    test-token
  $uri = ('{0}/?query=comments&card_id={1}' -f $uriroot, $card_id)
   $headers.Remove('X-AUTH-TOKEN') *>$null
  $headers.Add('X-AUTH-TOKEN',('{0}' -f $script:token))
  Invoke-RestMethod -Uri $uri -Headers $headers |
  Select-Object -expand data #|
  #format-table user_fullname,activitydatetime,activitydata -autosize -wrap
 
}
