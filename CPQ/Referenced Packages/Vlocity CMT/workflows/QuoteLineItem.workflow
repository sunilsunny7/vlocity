<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AssetRefIdForQLIUpdate</fullName>
        <field>AssetReferenceId__c</field>
        <formula>CASESAFEID(Id)</formula>
        <name>AssetRefIdForQLIUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AssetRefIdForQLI</fullName>
        <actions>
            <name>AssetRefIdForQLIUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>$Setup.RunTriggerAndWorkFlow__c.AllowWorkflow__c &amp;&amp; ( LOWER(ProvisioningStatus__c) == &apos;new&apos; || LOWER(ProvisioningStatus__c) == &apos;pendinginsert&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
