import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';

void main() {
  group('Add task', () {
    test('add task with a valid title ', () {
      final vm = TaskViewModel();
      String taskTitle = 'task';
      vm.addTask(taskTitle);

      expect(vm.tasks.length, equals(1));
      expect(vm.tasks.first.title, equals(taskTitle));
      expect(vm.tasks.first.done, equals(false));
    });

    test('empty task can\'t be added', () {
      final vm = TaskViewModel();
      vm.addTask('');

      expect(vm.tasks, isEmpty);
    });

    test('Already existing task can\'t be added', () {
      final vm = TaskViewModel();
      vm.addTask('Task');
      vm.addTask('Task');

      expect(vm.tasks.length, equals(1));
    });
  });

  group('delete tasks', () {
    test('invalid task index shouldn\'t have any effect', () {
      final vm = TaskViewModel();

      expect(vm.tasks, isEmpty);

      vm.deleteTask(-1);
      vm.deleteTask(0);

      expect(vm.tasks, isEmpty);
    });

    test('valid task index should delete task', () {
      final vm = TaskViewModel();
      vm.addTask('Task');

      vm.deleteTask(0);

      expect(vm.tasks, isEmpty);
    });
  });

  group('task tittle invalid tests', () {
    test('getReasonsWhyTitleIsInvalid empty task reason', () {
      final vm = TaskViewModel();
      Set<String>? reasons = vm.getReasonsWhyTitleIsInvalid('');

      expect(reasons, isNotNull);
      expect(reasons!.length, equals(1));
      expect(reasons.first, equals('Task should not be empty'));
    });

    test(
      'getReasonsWhyTitleIsInvalid already existing task can\'t be added',
      () {
        final vm = TaskViewModel();
        vm.addTask('Task');

        Set<String>? reasons = vm.getReasonsWhyTitleIsInvalid('Task');

        expect(reasons, isNotNull);
        expect(reasons!.length, equals(1));
        expect(reasons.first, equals('Task already Exists'));
      },
    );
  });

  group('completionPercentage', () {
    test('Empty task list should have 0 completion percentage', () {
      final vm = TaskViewModel();

      expect(vm.completionPercentage, equals(0));
    });

    test(
      'List with zero done elements should have 0 completion percentage',
      () {
        final vm = setupBaseCompletionPercentageTaskViewModel();

        expect(vm.completionPercentage, equals(0));
      },
    );

    test(
      'List with half tasks completed should have 0.5 completion percentage',
      () {
        final vm = setupBaseCompletionPercentageTaskViewModel();

        vm.toggleDone(0);

        expect(vm.completionPercentage, equals(0.5));
      },
    );
  });

  group('Task filter tests', () {
    test(
      'only tasks that match the applied filter should be shown (setFilter)',
      () {
        testFilterApplication(
          (TaskViewModel vm, TaskViewFilter taskViewFilter) =>
              vm.setFilter(taskViewFilter),
        );
      },
    );

    test(
      'only tasks that match the applied filter should be shown (setFilterByName)',
      () {
        testFilterApplication(
          (TaskViewModel vm, TaskViewFilter taskViewFilter) =>
              vm.setFilterByName(taskViewFilter.name),
        );
      },
    );

    test(
      'deleted tasks when filter is active should be deleted when filter is inactive as well',
      () {
        final vm = setupBaseFilterTaskViewModel();

        vm.setFilter(TaskViewFilter.pending);
        expect(vm.tasks.length, equals(1));
        expect(vm.tasks.first.title, 'Second');
        expect(vm.tasks.first.done, isFalse);

        vm.deleteTask(0);

        expect(vm.tasks, isEmpty);

        vm.setFilter(TaskViewFilter.all);
        expect(vm.tasks.length, equals(1));
        expect(vm.tasks.first.title, 'First');
        expect(vm.tasks.first.done, isTrue);
      },
    );

    test(
      'toggling done should affect if task is shown based on the applied filter',
      () {
        final vm = setupBaseFilterTaskViewModel();

        vm.setFilter(TaskViewFilter.done);
        expect(vm.tasks.length, equals(1));

        vm.toggleDone(0);

        expect(vm.tasks, isEmpty);

        vm.setFilter(TaskViewFilter.pending);
        expect(vm.tasks.length, equals(2));

        vm.toggleDone(0);
        expect(vm.tasks.length, equals(1));

        vm.setFilter(TaskViewFilter.done);
        expect(vm.tasks.length, equals(1));
      },
    );

    test(
      'completion percentage should be global regardless which filter is applied',
      () {
        final vm = setupBaseFilterTaskViewModel();

        expect(vm.completionPercentage, equals(0.5));

        vm.setFilter(TaskViewFilter.done);
        expect(vm.completionPercentage, equals(0.5));

        vm.setFilter(TaskViewFilter.pending);
        expect(vm.completionPercentage, equals(0.5));

        vm.setFilter(TaskViewFilter.all);
        expect(vm.completionPercentage, equals(0.5));
      },
    );
  });
}

void testFilterApplication(
  void Function(TaskViewModel, TaskViewFilter) applyFilter,
) {
  final vm = setupBaseFilterTaskViewModel();

  expect(vm.defaultFilter, equals(<String>{}));
  expect(vm.tasks.length, equals(2));

  applyFilter(vm, TaskViewFilter.done);
  expect(vm.defaultFilter, equals({TaskViewFilter.done.name}));

  expect(vm.tasks.length, equals(1));
  expect(vm.tasks.first.title, 'First');
  expect(vm.tasks.first.done, isTrue);

  applyFilter(vm, TaskViewFilter.pending);
  expect(vm.defaultFilter, equals({TaskViewFilter.pending.name}));
  expect(vm.tasks.length, equals(1));
  expect(vm.tasks.first.title, 'Second');
  expect(vm.tasks.first.done, isFalse);

  applyFilter(vm, TaskViewFilter.all);
  expect(vm.defaultFilter, equals(<String>{}));
  expect(vm.tasks.length, equals(2));
}

TaskViewModel setupBaseCompletionPercentageTaskViewModel() {
  final vm = TaskViewModel();
  vm.addTask('First');
  vm.addTask('Second');

  return vm;
}

TaskViewModel setupBaseFilterTaskViewModel() {
  final vm = setupBaseCompletionPercentageTaskViewModel();
  vm.toggleDone(0);
  
  return vm;
}
