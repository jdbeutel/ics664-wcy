/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
/* requires <g:javascript library="scriptaculous"/> */
var ExpandManager = {
    init: function() {
        $$('a.ExpandManager.swapToNextRow').invoke('observe', 'click', ExpandManager.swapToNextRow);
        $$('a.ExpandManager.swapToPreviousRow').invoke('observe', 'click', ExpandManager.swapToPreviousRow);
        $$('a.ExpandManager.swapToUpperPreviousRow').invoke('observe', 'click', ExpandManager.swapToUpperPreviousRow);
    },
    swapToNextRow: function(/*event*/) {
        var thisRow = this.up('tr');
        var nextRow = thisRow.next();
        var divToReveal = nextRow.down('div');
        thisRow.hide();
        divToReveal.hide();
        nextRow.show();
        Effect.BlindDown(divToReveal, {duration:0.5});
        return true; // have the browser also handle this event
    },
    swapToPreviousRow: function(/*event*/) {
        var thisRow = this.up('tr');
        var divToConceal = thisRow.down('div');
        var previousRow = thisRow.previous();
        Effect.BlindUp(divToConceal, {duration:0.5,
            afterFinish:function() {
                previousRow.show();
                thisRow.hide();
            }
        });
        return true; // have the browser also handle this event
    },
    swapToUpperPreviousRow: function(/*event*/) {
        var thisRow = this.up('tr').up('tr');
        var divToConceal = thisRow.down('div');
        var previousRow = thisRow.previous();
        Effect.BlindUp(divToConceal, {duration:0.5,
            afterFinish:function() {
                previousRow.show();
                thisRow.hide();
            }
        });
        return true; // have the browser also handle this event
    }
};
