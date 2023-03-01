tableextension 50100 "BSB Customer" extends Customer
{
    fields
    {
        field(50100; "BSB Favorite Book No."; Code[20])
        {
            Caption = 'Favorite Book No.';
            TableRelation = "BSB Book";

            trigger OnValidate()
            var
                BSBBook: Record "BSB Book";
            begin
                if ("BSB Favorite Book No." <> '') and
                    ("BSB Favorite Book No." <> xRec."BSB Favorite Book No.")
                then
                    BSBBook.TestBlocked("BSB Favorite Book No.");

                if ("BSB Favorite Book No." <> xRec."BSB Favorite Book No.") and (CurrFieldNo > 0) then
                    CalcFields("BSB Favorite Book Description");
            end;
        }
        field(50101; "BSB Favorite Book Description"; Text[100])
        {
            Caption = 'Favorite Book Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("BSB Book".Description where("No." = field("BSB Favorite Book No.")));
        }

    }
    //TODO Geperrtes Buch darf nich zugewiesen werden können
}