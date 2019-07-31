<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ReferenceIdForOrderPriceAdjUpdate</fullName>
        <field>Name</field>
        <formula>Id</formula>
        <name>ReferenceIdForOrderPriceAdjUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ReferenceIdForOrderPriceAdjUpdate</fullName>
        <actions>
            <name>ReferenceIdForOrderPriceAdjUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(Action__c, &apos;Add&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
