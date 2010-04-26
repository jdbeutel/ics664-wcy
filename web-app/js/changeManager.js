/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
// requires hidden field named originalValuesJSON
var ChangeManager = {
    originalValues: $H(),
    changedFields: $H(),
    init: function(form, saveButton, ignoredInputs) {
        ChangeManager.saveButton = saveButton;
        ignoredInputs.push('originalValuesJSON');
        var ovj = form['originalValuesJSON']; // saved from previous submits
        if ($F(ovj).empty()) {
            ChangeManager.originalValues = $H();
            $$('input, select').each(function(element) {
                ChangeManager.originalValues.set(element.name, $F(element))
            });
            ovj.value = ChangeManager.originalValues.toJSON();
        } else {
            ChangeManager.originalValues = $H($F(ovj).evalJSON());
            $$('input, select').each(function(element) {
                var n = element.name;
                if (ignoredInputs.indexOf(n) == -1 && ChangeManager.originalValues.get(n) != $F(element)) {
                    ChangeManager.changedFields.set(n, true);
                    element.addClassName('changed');
                }
            });
        }
        if (ChangeManager.changedFields.keys().length == 0) {
            saveButton.disable();
        } else {
            ChangeManager.highlightSaveButton();
        }
        $$('input, select').invoke('observe', 'change', ChangeManager.handleChange);
        return true; // have the browser also handle this event
    },
    handleChange: function(/*event*/) {
        if (ChangeManager.originalValues.get(this.name) == $F(this)) {
            this.removeClassName('changed');
            ChangeManager.changedFields.unset(this.name);
            if (ChangeManager.changedFields.keys().length == 0) {
                ChangeManager.saveButton.disable();
                ChangeManager.saveButton.setStyle({backgroundColor: 'white'});
            }
        } else {
            this.addClassName('changed');
            ChangeManager.changedFields.set(this.name, true);
            if (ChangeManager.saveButton.disabled) {
                ChangeManager.saveButton.enable();
                ChangeManager.highlightSaveButton();
            }
        }
        return true; // have the browser also handle this event
    },
    highlightSaveButton: function() {
        new Effect.Highlight(ChangeManager.saveButton, { startcolor: '#ffaa00', endcolor: '#ffff99', restorecolor: '#ffff99' });
    }
};

