/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class VlocityBatchFramework implements Database.AllowsCallouts, Database.Batchable<vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Iterable<vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Iterator<vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations>, System.Schedulable, vlocity_cmt.VlocityOpenInterface2 {
    global VlocityBatchFramework() {

    }
    global VlocityBatchFramework(List<vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations> input) {

    }
    global VlocityBatchFramework(String frequency) {

    }
    global static void abortBatchJobs() {

    }
    global static void abortScheduledBatchJob() {

    }
    global void execute(System.SchedulableContext ctx) {

    }
    global void execute(Database.BatchableContext context, List<vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations> scope) {

    }
    global void finish(Database.BatchableContext context) {

    }
    global static List<AsyncApexJob> getCurrentBatchJobs() {
        return null;
    }
    global static Datetime getNextFireTime(String frequency) {
        return null;
    }
    global static List<CronTrigger> getScheduledBatchJob() {
        return null;
    }
    global static String getTimeInCronFormat(Datetime dTime) {
        return null;
    }
    global Boolean hasNext() {
        return null;
    }
    global Object invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        return null;
    }
    global System.Iterator iterator() {
        return null;
    }
    global vlocity_cmt.VlocityBatchFramework.VlocityScheduledJobIterations next() {
        return null;
    }
    global static Boolean shouldExecuteJob(Datetime nextRunDateTime) {
        return null;
    }
    global System.Iterable start(Database.BatchableContext context) {
        return null;
    }
    global String startBatchScheduler(String frequency) {
        return null;
    }
    global static void startIntegrationProcedureBatch(String processName, List<Object> input, Map<String,Object> options) {

    }
    global static void startOpenInterfaceBatch(String processName, List<Object> input, Map<String,Object> options) {

    }
    global static void startScheduledJob(Id vlocityScheduledJobId) {

    }
    global static void startScheduledJobs() {

    }
    global static void startScheduledJobs(List<Id> vlocityScheduledJobIds) {

    }
global class VlocityScheduledJobIterations {
    global VlocityScheduledJobIterations() {

    }
}
}
