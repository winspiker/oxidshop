[{*
  *   *********************************************************************************************
  *      Please retain this copyright header in all versions of the software.
  *      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
  *
  *      Copyright (C) Josef A. Puckl | eComStyle.de
  *      All rights reserved - Alle Rechte vorbehalten
  *
  *      This commercial product must be properly licensed before being used!
  *      Please contact info@ecomstyle.de for more information.
  *
  *      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
  *      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
  *   *********************************************************************************************
  *}]
[{if !isset($oConfig)}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]
[{/if}]
[{assign var="oUser" value=$oViewConf->getUser()}]

[{if !$oConfig->getConfigParam('bAdminRightsOrderOverview')}]
    [{$smarty.block.parent}]
[{elseif !$oUser->isLimited()}]
    [{$smarty.block.parent}]
[{/if}]