import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/fdpi_repository.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk_contractor.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk_employee.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk_type.dart';

part 'spk_type_event.dart';
part 'spk_type_state.dart';

class SpkTypeBloc extends Bloc<SpkTypeEvent, SpkTypeState> {
  final FdpiRepository fdpiRepository;

  SpkTypeBloc({required this.fdpiRepository}) : super(SpkTypeInitial()) {
    on<GetSpkTypes>(_getSpkTypes);
    on<GetEmployee>(_getEmployee);
    on<GetContractor>(_getContractor);
    on<GetAllLookupData>(_getAllLookupData);
  }

  // Cache data
  List<SpkType> _cachedSpkTypes = [];
  List<Employee> _cachedEmployees = [];
  List<Contractor> _cachedContractors = [];

  Future<void> _getSpkTypes(
    GetSpkTypes event,
    Emitter<SpkTypeState> emit,
  ) async {
    emit(SpkTypeLoading());

    final result = await fdpiRepository.getSpkTypes(event.keyCode);

    result.fold(
      (error) => emit(
        SpkTypeLoadedFailure(errorMessage: error.message!, exception: error),
      ),
      (data) {
        _cachedSpkTypes = data;
        emit(
          SpkTypeLoadedSuccess(
            spkTypes: _cachedSpkTypes,
            employees: _cachedEmployees,
            contractors: _cachedContractors,
          ),
        );
      },
    );
  }

  Future<void> _getEmployee(
    GetEmployee event,
    Emitter<SpkTypeState> emit,
  ) async {
    emit(SpkTypeLoading());
    try {
      final result = await fdpiRepository.getEmployee();

      result.fold(
        (error) => emit(
          SpkTypeLoadedFailure(errorMessage: error.message!, exception: error),
        ),
        (data) {
          _cachedEmployees = data;
          emit(
            SpkTypeLoadedSuccess(
              spkTypes: _cachedSpkTypes,
              employees: _cachedEmployees,
              contractors: _cachedContractors,
            ),
          );
        },
      );
    } catch (e) {
      log('Error getting employee: $e');
      emit(
        SpkTypeLoadedFailure(
          errorMessage: 'Gagal memuat data employee',
          exception: Exception(e),
        ),
      );
    }
  }

  Future<void> _getContractor(
    GetContractor event,
    Emitter<SpkTypeState> emit,
  ) async {
    emit(SpkTypeLoading());
    try {
      final result = await fdpiRepository.getContractor();

      result.fold(
        (error) => emit(
          SpkTypeLoadedFailure(errorMessage: error.message!, exception: error),
        ),
        (data) {
          _cachedContractors = data;
          emit(
            SpkTypeLoadedSuccess(
              spkTypes: _cachedSpkTypes,
              employees: _cachedEmployees,
              contractors: _cachedContractors,
            ),
          );
        },
      );
    } catch (e) {
      log('Error getting contractor: $e');
      emit(
        SpkTypeLoadedFailure(
          errorMessage: 'Gagal memuat data contractor',
          exception: Exception(e),
        ),
      );
    }
  }

  Future<void> _getAllLookupData(
    GetAllLookupData event,
    Emitter<SpkTypeState> emit,
  ) async {
    emit(SpkTypeLoading());
    try {
      // Create futures
      final spkTypesResultFuture = fdpiRepository.getSpkTypes('SPK_TYPE');
      final employeeResultFuture = fdpiRepository.getEmployee();
      final contractorResultFuture = fdpiRepository.getContractor();

      // Await all - tetap type-safe
      final spkTypesResult = await spkTypesResultFuture;
      final employeeResult = await employeeResultFuture;
      final contractorResult = await contractorResultFuture;

      // Extract data
      List<SpkType> spkTypes = [];
      List<Employee> employees = [];
      List<Contractor> contractors = [];
      String? errorMsg;
      Exception? errorException;

      spkTypesResult.fold((error) {
        errorMsg = error.message;
        errorException = error;
      }, (data) => spkTypes = data);

      employeeResult.fold((error) {
        log('Error getting employee: ${error.message}');
      }, (data) => employees = data);

      contractorResult.fold((error) {
        log('Error getting contractor: ${error.message}');
      }, (data) => contractors = data);

      // If spkTypes failed, emit error
      if (errorMsg != null && errorException != null) {
        emit(
          SpkTypeLoadedFailure(
            errorMessage: errorMsg!,
            exception: errorException!,
          ),
        );
        return;
      }

      // Cache data
      _cachedSpkTypes = spkTypes;
      _cachedEmployees = employees;
      _cachedContractors = contractors;

      emit(
        SpkTypeLoadedSuccess(
          spkTypes: spkTypes,
          employees: employees,
          contractors: contractors,
        ),
      );
    } catch (e) {
      log('Error loading lookup data: $e');
      emit(
        SpkTypeLoadedFailure(
          errorMessage: 'Gagal memuat data lookup',
          exception: Exception(e),
        ),
      );
    }
  }

  // ===== HELPER METHODS =====

  /// Get employee name by ID
  String getEmployeeName(String idUser) {
    try {
      final employee = _cachedEmployees.firstWhere(
        (emp) => emp.idUser == idUser,
      );
      return employee.namaEmployee;
    } catch (e) {
      log('Employee not found for ID: $idUser');
      return idUser;
    }
  }

  /// Get contractor name by ID
  String getContractorName(String idVendor) {
    try {
      final contractor = _cachedContractors.firstWhere(
        (con) => con.idVendor == idVendor,
      );
      return contractor.namaContractor;
    } catch (e) {
      log('Contractor not found for ID: $idVendor');
      return idVendor;
    }
  }

  /// Get SPK Type label by code
  String getSpkTypeLabel(String code) {
    try {
      final match = _cachedSpkTypes.firstWhere((item) => item.str1 == code);
      return match.str2;
    } catch (e) {
      log('SPK Type not found for code: $code');
      return code;
    }
  }
}
