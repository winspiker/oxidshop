<label class="err">
    [{ $msg }] [{if $param}][<b>[{$param}]</b>][{/if}]
    <input type="hidden" name="last_err" value="[{$param}]">
    <hr>
    [{if $email_sent}]<span style="color: green;">Ok</span>[{/if}]<button class="status_btn send_error" name="fnc" value="sendSupportEmail">Support e-mail senden</button> </label><br>