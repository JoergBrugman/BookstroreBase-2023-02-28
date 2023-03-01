query 50100 "BSB Customer Query"
{
    Caption = 'Customer Query';
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(City; City)
            {
            }
            dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
            {
                DataItemLink = Code = Customer."Salesperson Code";
                column("Code"; "Code")
                {
                }
                column(Name_SalespersonPurchaser; Name)
                {
                }
            }
        }

    }

    trigger OnBeforeOpen()
    begin

    end;
}
