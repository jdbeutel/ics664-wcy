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
        divToReveal.hide();
        nextRow.show();
        var options = {duration:0.5};
        if (Prototype.Browser.WebKit) { // for Chrome, at least, to help keep the :hover
            var frameCount = 0;
            options.afterUpdate = function() {
                if (frameCount++ == 3) {
                    thisRow.hide();
                }
            }
        } else {
            options.beforeStart = function() {
                thisRow.hide();
            }
        }
        Effect.BlindDown(divToReveal, options);
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
