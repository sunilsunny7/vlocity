<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ReferenceIdForOrderAppliedPromotionItem</fullName>
        <field>Name</field>
        <formula>Id</formula>
        <name>ReferenceIdForOrderAppliedPromotionItem</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ReferenceIdForOrderAppliedPromotionItem</fullName>
        <actions>
            <name>ReferenceIdForOrderAppliedPromotionItem</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNULL( Name)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
