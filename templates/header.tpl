<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(function(){
		{if $action == 'form' }
		$('.track-remove').click(function(){
			$('.ajax-button').hide();
			$(this).after('<img id="Loading" src="css/loading.gif" alt="Saving Changes" title="Saving Changes" />');
			var productId = {{$productId}};
			var metaFieldId = $(this).attr('name').replace('TrackRemove-','');
			var order = $("#TrackOrder-" + metaFieldId).val();
			var url = '?ajax=1&action=form&remove=1&productId=' + productId + '&metaFieldId=' + metaFieldId + '&order=' + order;
			var $row = $(this).closest('tr.data');
			$.getJSON(url, function(){
				$('#Loading').remove();
				$('.ajax-button').show();
				
				// move all the rows up
				// then delete the last row
				var $nextRow = $row.next('tr.data');
				while($nextRow.length > 0) {
					// take all the data and put it in the current $row
					copyRowData($row, $nextRow);
					$row = $nextRow;
					$nextRow = $row.next('tr.data');						
				}
				
				$row.remove();
				$('.track-up:first').hide();
				$('.track-down:last').hide();
				
				$('#SavedMessage').slideDown();
				setTimeout(function(){ $('#SavedMessage').slideUp(); }, 5000);
				
				if ($("#ExistingTracks tbody tr").length == 0)
				{
					$('#ExistingTracks').hide();
					$('#NoTracks').show();
				}
			});
		});
		$('.track-up:first').hide();
		$('.track-down:last').hide();
		$('.track-up').click(function(){
			$('.ajax-button').hide();
			$(this).after('<img id="Loading" src="css/loading.gif" alt="Saving Changes" title="Saving Changes" />');
			var productId = {{$productId}};
			var $row = $(this).parents('tr');
			var metaFieldId = $(this).attr('name').replace('TrackUp-','');
			var order = $("#TrackOrder-" + metaFieldId).val();
			var url = '?ajax=1&action=form&up=1&productId=' + productId + '&metaFieldId=' + metaFieldId + '&order=' + order;
			$.getJSON(url, function(){ 
				// swap the data from one row to the next
				// do not swap rows (which is way easier) because the ID of the Track
				// remains with the key... Track1, Track2, etc.  So, just swap the data
				swapRowData($row, $row.prev());

				
				$('#Loading').remove();
				$('.ajax-button').show();
				$('.track-up:first').hide();
				$('.track-down:last').hide();
				$('#SavedMessage').slideDown();
				setTimeout(function(){ $('#SavedMessage').slideUp(); }, 5000);
			});
		});
		$('.track-down').click(function(){
			$('.ajax-button').hide();
			$(this).after('<img id="Loading" src="css/loading.gif" alt="Saving Changes" title="Saving Changes" />');
			var productId = {{$productId}};
			var $row = $(this).parents('tr');
			var metaFieldId = $(this).attr('name').replace('TrackDown-','');
			var order = $("#TrackOrder-" + metaFieldId).val();
			var url = '?ajax=1&action=form&down=1&productId=' + productId + '&metaFieldId=' + metaFieldId + '&order=' + order;
			$.getJSON(url, function() {
				// swap the data from one row to the next
				// do not swap rows (which is way easier) because the ID of the Track
				// remains with the key... Track1, Track2, etc.  So, just swap the data
				swapRowData($row, $row.next());

				$('#Loading').remove();
				$('.ajax-button').show();
				$('.track-up:first').hide();
				$('.track-down:last').hide();
				$('#SavedMessage').slideDown();
				setTimeout(function(){ $('#SavedMessage').slideUp(); }, 5000);
			});
		});


		$('#SaveTracks').click(function(){
			$('.ajax-button').hide();
			$(this).after('<img id="Loading" src="css/loading.gif" alt="Saving Changes" title="Saving Changes" />');
			$.post("?ajax=1&action=form&productId={{$productId}}&save=1", $("#TrackListing").serialize(), function(){
				//$('#ExistingTracks a').each(function(){
				//	var trackId = $(this).attr('id').replace('Track-', '');
				//	var name = $("#TrackName-" + trackId).val();
				//	$(this).text(name);
				//});
				$('#Loading').remove();
				$('.ajax-button').show();
				$('.track-up:first').hide();
				$('.track-down:last').hide();
				$('#SavedMessage').slideDown();
				setTimeout(function(){ $('#SavedMessage').slideUp(); }, 5000);
			});
		});
		
		$('.browse').click(function(){
			currentButton = this;
			if (typeof browser == "undefined" || browser.closed) {
				browser = window.open("index.php?action=browse","browse","location=1,status=1,scrollbars=1, width=400,height=500");
			}
			browser.focus();
		});
		{/if}
		{if $action == 'browse' }
		$('.file').click(function(ev){
			ev.preventDefault();
			window.opener.selectFile(this.rel);
			window.close();
		});
		
		{/if}
		
	});
	{if $action == 'form' }
	var browser;
	var currentButton = null;
	function selectFile(file) {
		var index = currentButton.id.replace('NewTrackFileName', '');
		$("#NewTrack" + index).val(file);
	}
	// copy data from a to b and from b to a
	function swapRowData($a, $b) {
		var $aTrackURLField = $a.find('.track_url');
		var $aTrackNameField = $a.find('.track_name');
		var tmpURL = $aTrackURLField.val();
		var tmpName = $aTrackNameField.val();

		var $bTrackURLField = $b.find('.track_url');
		var $bTrackNameField = $b.find('.track_name');
		$aTrackURLField.val($bTrackURLField.val());
		$aTrackNameField.val($bTrackNameField.val());
		$a.find(".sound a").attr("href", $bTrackURLField.val());
		$bTrackURLField.val(tmpURL);
		$bTrackNameField.val(tmpName);
		$b.find(".sound a").attr("href", tmpURL);
	}
	// copy data from b to a
	function copyRowData($a, $b) {
		var $bTrackURLField = $b.find('.track_url');
		var $bTrackNameField = $b.find('.track_name');
		$a.find('.track_url').val($bTrackURLField.val());
		$a.find('.track_name').val($bTrackNameField.val());
		$a.find(".sound a").attr("href", $bTrackURLField.val());
	}
	{/if}
	</script>
	<link rel="stylesheet" type="text/css" href="soundmanager/inlineplayer.css" />
	<link rel="stylesheet" type="text/css" href="soundmanager/flashblock/flashblock.css" />
	<script type="text/javascript" src="soundmanager/soundmanager2-nodebug-jsmin.js"></script>
	<script type="text/javascript" src="soundmanager/inlineplayer.js"></script>
	<link href="css/css.css" media="screen" rel="stylesheet" type="text/css" />

</head>
<body class="adminz">
	
	{if $action != 'list'}
	<div id="header"> 
		<h1><a href="index.php">{$title}</a></h1>      
	</div> 

	<div id="container" class="clearfix"> 

		<ul id="tabs"> 
			{foreach $mainnav as $link}
			{strip}
			<li><a href="{$link.href}" id="{$link.class}">{$link.name}</a></li>
			{/strip}
			{/foreach}
		</ul>
		
		<div id="main" class="clearfix">
	{/if}
