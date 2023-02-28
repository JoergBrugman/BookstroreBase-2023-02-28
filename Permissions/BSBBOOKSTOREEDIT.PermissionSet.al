permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.';
    // Assignable = true;

    Permissions =
        table "BSB Book" = x,
        tabledata "BSB Book" = RIMD;
}

