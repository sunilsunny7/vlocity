<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AssetPricingAdjRefIdForOLIPAUpdate</fullName>
        <field>AssetPricingAdjustmentReferenceId__c</field>
        <formula>Id</formula>
        <name>AssetPricingAdjRefIdForOLIPAUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AssetPricingAdjustmentRefIdForOLIPA</fullName>
        <actions>
            <name>AssetPricingAdjRefIdForOLIPAUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(LOWER(ProvisioningStatus__c) == &apos;new&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
