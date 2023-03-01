codeunit 50100 "BSB Subscriber Store"
{
    var
        BookHintTxt: Label 'Please do not forget to enter Favorite Book No.';

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure BookHintOnAfterInsertCust(var Rec: Record Customer)
    begin
        if Rec."BSB Favorite Book No." = '' then
            Message(BookHintTxt);
    end;
}