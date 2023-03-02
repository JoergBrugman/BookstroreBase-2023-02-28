/// <summary>
/// Table BSB Book (ID 50100). Master-Table zur Definition von Büchern
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book';
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(5; Type; enum "BSB Book Type")
        {
            Caption = 'Type';
            // OptionMembers = " ",Hardcover,Paperback;
            // OptionCaption = ' ,Hardcover,Paperback';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author) { }
    }

    #region Table Trigger
    trigger OnInsert()
    begin
        Created := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeOnDelete(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        Error(OnDeleteErr, TableCaption);
    end;
    #endregion Table Trigger

    /// <summary>
    /// TestBlocked prüft, prüft das Buch im Rec und gibt einen Fehler aus, wenn es gesperrt ist.
    /// </summary>
    procedure TestBlocked()
    begin
        TestBlocked(Rec);
    end;

    /// <summary>
    /// TestBlocked prüft das Buch im Parameter BSBBook und gibt einen Fehler aus, wenn es gesperrt ist.
    /// </summary>
    /// <param name="BSBBook">BSBBook: Record des zu prüfendes Buchs</param>
    procedure TestBlocked(BSBBook: Record "BSB Book")
    begin
        BSBBook.TestField(Blocked, false);
    end;

    /// <summary>
    /// TestBlocked liest das Buch zum Code ein und gibt einen Fehler aus, wenn es gesperrt ist.
    /// </summary>
    /// <param name="BookNo">BookNo: Code des zu prüfenden Buchs</param>
    procedure TestBlocked(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if (BookNo <> '') then begin
            BSBBook.Get(BookNo);
            TestBlocked(BSBBook);
        end;
    end;

    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    procedure ShowCard(BSBBook: Record "BSB Book")
    begin
        page.Run(Page::"BSB Book Card", BSBBook);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if BSBBook.Get(BookNo) then
            ShowCard(BSBBook);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var xRec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;

    var
        OnDeleteErr: Label 'A %1 cannot be deleted', Comment = '"DEU"=Ein %1 kann nicht gelöscht werden';
        XXXXXMsg: Label 'XYXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
}
