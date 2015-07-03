jQuery.timeago.settings.allowFuture = true;
jQuery.timeago.settings.strings['en'].prefixFromNow = 'in';
jQuery.timeago.settings.strings['en'].suffixFromNow = null;

jQuery('.timeago').livequery(function() {
	jQuery(this).timeago();
});