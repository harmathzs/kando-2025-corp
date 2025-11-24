trigger OrderTrigger on Order (before insert, after insert, before update, after update, before delete, after delete) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        OrderTriggerHandler.handleAfterUpdateOrder(Trigger.oldMap, Trigger.newMap);
    }
}