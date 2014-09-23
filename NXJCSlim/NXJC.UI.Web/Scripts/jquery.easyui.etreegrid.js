/** 
 * etreegrid - jQuery EasyUI 
 *  
 * Licensed under the GPL: 
 *   http://www.gnu.org/licenses/gpl.txt 
 * 
 * Copyright 2013 maddemon [ zhengliangjun@gmail.com ]  
 *  
 * Dependencies: 
 *   treegrid 
 *   messager 
 *  
 */
(function ($) {

    function buildGrid(target) {
        var opts = $.data(target, 'etreegrid').options;
        $(target).treegrid($.extend({}, opts, {
            onDblClickCell: function (field, row) {
                if (opts.editing) {
                    $(this).etreegrid("editRow", row);
                    focusEditor(field);
                }
            },
            onClickCell: function (field, row) {
                if (opts.editing && opts.editIndex >= 0) {
                    if (!trySaveRow()) {
                        focusEditor(field);
                        return;
                    }
                }
            },
            onAfterEdit: function (row, changes) {
                opts.editIndex = undefined;
                var url = row.isNewRecord ? opts.saveUrl : opts.updateUrl;
                if (url) {
                    $.post(url, row).done(function (json, statusText, xhr) {
                        if (row.isNewRecord) {
                            row.isNewRecord = false;
                            //remove new  
                            $(target).treegrid("remove", row[opts.idField]);
                            row[opts.idField] = json[opts.idField] || json.data[opts.idField];
                            $(target).treegrid("append", { parent: row[opts.parentIdField], data: [row] });
                            //append new  
                        } else {
                            //refresh  
                            $(target).treegrid("refresh", row[opts.idField]);
                        }
                    }).error(function (xhr) {
                        var result = eval("(" + xhr.responseText + ")");
                        $.messager.alert("失败", result.message || result, "warning");
                    });
                    opts.onSave.call(target, row);
                } else {
                    opts.onSave.call(target, row);
                }
                if (opts.onAfterEdit) opts.onAfterEdit.call(target, row);
            },
            onCancelEdit: function (row) {
                opts.editIndex = undefined;
                if (row.isNewRecord) {
                    $(this).treegrid("remove", row[opts.idField]);
                }
                if (opts.onCancelEdit) opts.onCancelEdit.call(target, row);
            },
            onBeforeLoad: function (row, param) {
                if (opts.onBeforeLoad.call(target, row, param) == false) {
                    return false;
                };
                $(this).treegrid("rejectChanges");
            }
        }));

        function trySaveRow() {
            if (!$(target).treegrid("validateRow", opts.editIndex)) {
                $(target).treegrid("select", opts.editIndex);
                return false;
            }
            if (opts.onBeforeSave.call(this, opts.editIndex) == false) {
                setTimeout(function () {
                    $(target).treegrid('select', opts.editIndex);
                }, 0);
                return false;
            }
            $(target).treegrid('endEdit', opts.editIndex);
            return true;
        }

        function focusEditor(field) {
            var editor = $(target).treegrid('getEditor', { index: opts.editIndex, field: field });
            if (editor) {
                editor.target.focus();
            } else {
                var editors = $(target).treegrid('getEditors', opts.editIndex);
                if (editors.length) {
                    editors[0].target.focus();
                }
            }
        }
    }

    $.fn.etreegrid = function (options, param) {
        if (typeof (options) == "string") {
            var method = $.fn.etreegrid.methods[options];
            if (method) {
                return method(this, param);
            } else {
                return this.treegrid(options, param);
            }
        }

        options = options || {};
        return this.each(function () {
            var state = $.data(this, "etreegrid");
            if (state) {
                $.extend(state.options, options);
            } else {
                $.data(this, "etreegrid", { options: $.extend({}, $.fn.etreegrid.defaults, $.fn.etreegrid.parseOptions(this), options) });
            }
            ;
            buildGrid(this);

        });
    };

    $.fn.etreegrid.parseOptions = function (target) {
        return $.extend({}, $.fn.treegrid.parseOptions(target), {});
    };

    $.fn.etreegrid.methods = {
        options: function (jq) {
            var opts = $.data(jq[0], "etreegrid").options;
            return opts;
        },
        enableEditing: function (jq) {
            return jq.each(function () {
                var opts = $.data(this, "etreegrid").options;
                opts.editing = true;
            });
        },
        disableEditing: function (jq) {
            return jq.each(function () {
                var opts = $.data(this, "etreegrid").options;
                opts.editing = false;
            });
        },
        editRow: function (jq, row) {
            return jq.each(function () {
                var dg = $(this);
                var opts = $.data(this, "etreegrid").options;
                var index = row[opts.idField];
                var editIndex = opts.editIndex;
                if (editIndex != index) {
                    if (dg.treegrid("validateRow", editIndex)) {
                        if (editIndex >= 0) {
                            if (opts.onBeforeSave.call(this, editIndex) == false) {
                                setTimeout(function () {
                                    dg.treegrid("select", editIndex);
                                }, 0);
                                return;
                            }
                        }
                        dg.treegrid("endEdit", editIndex);
                        dg.treegrid("beginEdit", index);
                        opts.editIndex = index;
                        var node = dg.treegrid("find", index);
                        opts.onEdit.call(this, node);
                    } else {
                        setTimeout(function () {
                            dg.treegrid("select", editIndex);
                        }, 0);
                    }
                }
            });
        },
        addRow: function (jq) {
            return jq.each(function () {
                var dg = $(this);
                var opts = $.data(this, "etreegrid").options;
                var editIndex = opts.editIndex;
                if (opts.editIndex >= 0) {
                    if (!dg.treegrid("validateRow", editIndex)) {
                        dg.treegrid("select", editIndex);
                        return;
                    }
                    if (opts.onBeforeSave.call(this, opts.editIndex) == false) {
                        setTimeout(function () {
                            dg.treegrid('select', opts.editIndex);
                        }, 0);
                        return;
                    }
                    dg.treegrid('endEdit', opts.editIndex);
                }
                var selected = dg.treegrid("getSelected");
                var parentId = selected ? selected[opts.idField] : 0;
                var newRecord = { isNewRecord: true };
                newRecord[opts.idField] = 0;
                newRecord[opts.parentIdField] = parentId;
                dg.treegrid("append", { parent: parentId, data: [newRecord] });
                opts.editIndex = 0;
                dg.treegrid("beginEdit", opts.editIndex);
                dg.treegrid("select", opts.editIndex);
            });
        },
        saveRow: function (jq) {
            return jq.each(function () {
                var dg = $(this);
                var opts = $.data(this, 'etreegrid').options;
                if (opts.editIndex >= 0) {
                    if (!dg.treegrid("validateRow", opts.editIndex)) {
                        dg.treegrid("select", opts.editIndex);
                        return;
                    }
                    if (opts.onBeforeSave.call(this, opts.editIndex) == false) {
                        setTimeout(function () {
                            dg.treegrid('select', opts.editIndex);
                        }, 0);
                        return;
                    }
                    $(this).treegrid('endEdit', opts.editIndex);
                }
            });
        },
        cancelRow: function (jq) {
            return jq.each(function () {
                var index = $(this).etreegrid('options').editIndex;
                $(this).treegrid('cancelEdit', index);
            });
        },
        removeRow: function (jq) {
            return jq.each(function () {
                var dg = $(this);
                var opts = $.data(this, 'etreegrid').options;
                var row = dg.treegrid('getSelected');
                if (!row) return;
                if (row.isNewRecord) {
                    dg.treegrid("remove", row[opts.idField]);
                    return;
                }
                $.messager.confirm("确认", "确认删除这条数据吗？", function (r) {
                    if (!r) return;
                    var idValue = row[opts.idField];
                    if (opts.deleteUrl) {
                        $.post(opts.deleteUrl, { id: idValue }).done(function (json) {
                            dg.treegrid("remove", idValue);
                            opts.onRemove.call(dg[0], json, row);
                        }).error(function (xhr) {
                            var json = eval('(' + xhr.responseText + ')');
                            $.messager.alert('错误', json.message || json, "warning");
                        });
                    } else {
                        dg.datagrid('cancelEdit', idValue);
                        dg.datagrid('deleteRow', idValue);
                        opts.onRemove.call(dg[0], row);
                    }
                });
            });
        }
    };

    $.fn.etreegrid.defaults = $.extend({}, $.fn.treegrid.defaults, {
        editing: true,
        editIndex: -1,
        messager: {},

        url: null,
        saveUrl: null,
        updateUrl: null,
        deleteUrl: null,

        onAdd: function (row) { },
        onEdit: function (row) { },
        onBeforeSave: function (index) { },
        onSave: function (row) { },
        onRemove: function (row) { },
    });
})(jQuery);