# HW2
# 

1. Какие проблемы мешают нам использовать storyboard в реальных проектах?
- Storyboards хрупкие, ошибка может привести к падению приложения на этапе выполнения. Некоторые пользовательские интерфейсы и анимации могут быть сложно или невозможно реализовать с использованием только storyboard. Если несколько разработчиков работают над одним и тем же storyboard, это может привести к конфликтам при слиянии изменений в системе контроля версий, так как storyboard представляют собой большие файлы XML.
2. Что делает код на строках 25 и 29?
- Строка 25 отключает автоматическое создание ограничений (constraints) для объекта `UILabel`, названного `title.`Строка 29** добавляет `UILabel`, названный `title`, в иерархию представлений текущего контроллера представления. Вызов `addSubview(title)` означает, что `title` теперь будет отображаться на экране в рамках основного представления контроллера.
3. Что такое safe area layout guide?
- "Safe Area Layout Guide" в iOS является концепцией в Auto Layout, предназначенной для помощи в размещении контента в пределах видимой области интерфейса. Она помогает обеспечить, что важный контент не будет случайно скрыт системными элементами или вырезами.
4. Что такое [weak self] на строке 23 и почему это важно?
- `[weak self]` в контексте замыкания (closure) в Swift указывает, что `self` должен быть захвачен как слабая ссылка (weak reference). Это делается для предотвращения возникновения сильной ссылочной цикличности (strong reference cycle).
5. Что такое тип valueChanged? Что такое Void и Double?
- `valueChanged` - это свойство, которое представляет собой замыкание
- `Double` – это тип данных в Swift, который используется для представления двойной точности чисел с плавающей запятой.
- `Void` – это способ описать отсутствие возвращаемого значения.
6. Что означает clipsToBounds?
- `clipsToBounds` – это свойство `UIView`, которое определяет, будут ли подвью (subviews) обрезаны, чтобы помещаться в рамках своего супервью. Если `clipsToBounds` установлен в `true`, все подвью, которые выходят за границы своего супервью, будут обрезаны или "сокрыты".