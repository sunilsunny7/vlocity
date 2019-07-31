<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ReferenceIdForQuoteAppliedPromotionItem</fullName>
        <field>Name</field>
        <formula>Id</formula>
        <name>ReferenceIdForQuoteAppliedPromotionItem</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ReferenceIdForQuoteAppliedPromotionItem</fullName>
        <actions>
            <name>ReferenceIdForQuoteAppliedPromotionItem</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNULL( Name)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
