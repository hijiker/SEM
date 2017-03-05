!------------------------------------------------------------------------------!
!                                                                              !
!   PROGRAM : SEM_write.f90                                                    !
!                                                                              !
!   PURPOSE : Write each variables in the RESULT folder.                       !
!                                                                              !
!                                                             2017.03.02 K.Noh !
!                                                                              !
!------------------------------------------------------------------------------!
          SUBROUTINE OUTPUT
            USE SEM_module,                                                     &
              ONLY : N, Ny, Nz, time, file_name, dir_name, path_name

            USE SEM_module,                                                     &
              ONLY : Y, Z, U, V, W, RS, U_INLET, V_INLET, W_INLET, SEM_EDDY,    &
                     U_COMB, V_COMB, W_COMB

              IMPLICIT NONE
              INTEGER :: it,j,k
              REAL(KIND=8) :: time_sta, time_end

              ! WRITE(*,*) '----------------------------------------------------'
              ! WRITE(*,*) '              WRITING PROCESS STARTED               '
              CALL CPU_TIME(time_sta)
              dir_name = 'RESULT'

              !----------------------------------------------------------------!
              !                       Outputs for U Slice                      !
              !----------------------------------------------------------------!
              file_name = '/U_ins.plt'
              path_name = TRIM(dir_name)//TRIM(file_name)

              OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
              WRITE(100,*) 'VARIABLES = X,Y,U_ins,V_ins,W_ins'
              WRITE(100,"(2(A,I3,2X))")' ZONE  I = ',Nz,' J = ',Ny
              WRITE(100,*) 'SOLUTIONTIME =',time

              DO j = 1,Ny
                DO k = 1,Nz

                    WRITE(100,"(5F15.9)") Z(k),Y(j),                            &
                                          U_COMB(j,k),V_COMB(j,k),W_COMB(j,k)

                END DO
              END DO
              WRITE(100,*)
              CLOSE(100)

              !----------------------------------------------------------------!
              !                   Outputs for Eddy posoitions                  !
              !----------------------------------------------------------------!
              file_name = '/EDDY_POS.plt'
              path_name = TRIM(dir_name)//TRIM(file_name)

              OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
              WRITE(100,*) 'VARIABLES = X,Y,Z'
              WRITE(100,*) 'ZONE'
              WRITE(100,*) 'SOLUTIONTIME =',time

              DO it = 1,N
                WRITE(100,*) SEM_EDDY(it)%X_pos*10,SEM_EDDY(it)%Y_pos,             &
                             SEM_EDDY(it)%Z_pos
              END DO
              WRITE(100,*)
              CLOSE(100)

              CALL CPU_TIME(time_end)

              ! WRITE(*,*) '           WRITING PROCESS IS COMPLETED            '
              ! WRITE(*,*) '  Total Writing time : ',time_end - time_sta,' s'
              ! WRITE(*,*) '----------------------------------------------------'
              ! WRITE(*,*) ''

              ! DEALLOCATE(Y,Z,U,V,W,RS,U_INLET,V_INLET,W_INLET,SEM_EDDY)
              ! DEALLOCATE(U_COMB,V_COMB,W_COMB)

          END SUBROUTINE OUTPUT
