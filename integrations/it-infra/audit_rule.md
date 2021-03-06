# Правило для отправки уведомления об удалении объекта

> [Правило: Аудит](https://nur.axibase.com/rule/edit.xhtml?name=%D0%90%D1%83%D0%B4%D0%B8%D1%82#notifications_email).
>
> [Скачать](./resources/rule_2.xml) конфигурацию.

1. Откройте страницу **Alerts > Rules**, нажмите **New**.

   ![](./images/rule_1.png)

2. Вкладка **Overview**: укажите имя нового правила.

   ![](./images/rule_2.png)

   > Чтобы посмотреть описание всех настроек, используйте кнопку **Help** в верхнем правом углу вкладки.
   >
   > ![](./images/rule_3.png)

3. Вкладка **Filters**: в меню **Data Type** выберите **Message**, установите `Type = audit`.

   ![](./images/rule_4.png)

   Укажите **Filter Expression**: `tags.action == 'delete'`.

   ![](./images/rule_8.png)

4. Вкладка **Condition**: укажите условие, на которое должно сработать правило, в данном случае `true`, чтобы правило срабатывало всегда.

   ![](./images/rule_5.png)

   Укажите переменную `msgs`, которая будет хранить список сообщений об удалении объектов данным пользователем за последние 3 дня:

   ![](./images/rule_9.png)

   объекты `message` извлекаются из базы с помощью функции [`db_messages`](https://axibase.com/docs/atsd/rule-engine/functions-message.html#db_messages).

5. Вкладка **Email**: укажите получателей и настройте **On Open** триггер.

   > Предварительно нужно настроить [**Mail Client**](https://axibase.com/docs/atsd/administration/mail-client.html#mail-client).

   ![](./images/rule_6.png)

   Для форматирования списка объектов `message` используется функция [`addTable`](https://axibase.com/docs/atsd/rule-engine/functions-table.html#addtable-for-objects).

6. Для проверки уведомления нажмите **Test**.

   ![](./images/rule_7.png)

   ![](./images/mail_notif_about_delete.png)

7. Сохраните правило.