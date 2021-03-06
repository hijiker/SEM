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
              ONLY : N, Ny, Nz, Nt, dt, time, file_name, dir_name, path_name

            USE SEM_module,                                                     &
              ONLY : Y, Z, U, V, W, T, RS, THS,                                 &
                     U_INLET, V_INLET, W_INLET, T_INLET, SEM_EDDY,    &
                     U_COMB, V_COMB, W_COMB, T_COMB, U_c, U_pr, rms_pr

              IMPLICIT NONE
              INTEGER :: it,j,k
              REAL(KIND=8) :: time_sta, time_end, U_mean(4,1:Ny), rms_mean(8,1:Ny)

              U_mean(1:4,1:Ny)   = 0.0
              rms_mean(1:8,1:Ny) = 0.0

              ! WRITE(*,*) '----------------------------------------------------'
              ! WRITE(*,*) '              WRITING PROCESS STARTED               '
              CALL CPU_TIME(time_sta)
              dir_name = 'RESULT'

              !----------------------------------------------------------------!
              !                       Outputs for U Slice                      !
              !----------------------------------------------------------------!
              ! file_name = '/U_ins.plt'
              ! path_name = TRIM(dir_name)//TRIM(file_name)
              !
              ! OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
              ! WRITE(100,*) 'VARIABLES = Z,Y,U_ins,V_ins,W_ins'
              ! WRITE(100,"(2(A,I3,2X))")' ZONE  I = ',Nz,' J = ',Ny
              ! WRITE(100,*) 'SOLUTIONTIME =',time
              !
              ! DO j = 1,Ny
              !   DO k = 1,Nz
              !
              !       WRITE(100,"(5F15.9)") Z(k),Y(j),                            &
              !                             U_COMB(j,k),V_COMB(j,k),W_COMB(j,k)
              !
              !   END DO
              ! END DO
              ! WRITE(100,*)
              ! CLOSE(100)

              !----------------------------------------------------------------!
              !                   Outputs for U mean profiles                  !
              !----------------------------------------------------------------!
              file_name = '/Mean_profiles.plt'
              path_name = TRIM(dir_name)//TRIM(file_name)

              IF ( INT(time/dt) == Nt) THEN
                OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
                WRITE(100,*)'VARIABLES = Y,U_ins,U_exac,V_ins,V_exac,W_ins,W_exac,T_ins,T_exac'

                DO j = 1,Ny
                  DO k = 1,Nz
                    U_mean(1,j) = U_mean(1,j) + U(j,k)
                    U_mean(2,j) = U_mean(2,j) + V(j,k)
                    U_mean(3,j) = U_mean(3,j) + W(j,k)
                    U_mean(4,j) = U_mean(4,j) + T(j,k)
                  END DO
                    U_mean(1:4,j) = U_mean(1:4,j)/Nz
                    WRITE(100,"(9F15.9)") Y(j), U_pr(1,j), U_mean(1,j),         &
                                                U_pr(2,j), U_mean(2,j),         &
                                                U_pr(3,j), U_mean(3,j),         &
                                                U_pr(4,j), U_mean(4,j)
                END DO
                WRITE(100,*)
                CLOSE(100)
              END IF

              !----------------------------------------------------------------!
              !              Outputs for Reynolds stress profiles              !
              !----------------------------------------------------------------!
              file_name = '/RMS_profiles.plt'
              path_name = TRIM(dir_name)//TRIM(file_name)

              IF ( INT(time/dt) == Nt) THEN
                OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
                WRITE(100,*)'VARIABLES = Y,uu,uu_exac,vv,vv_exac,ww,ww_exac,tt,tt_exac,uv,uv_exac,ut,ut_exac,vt,vt_exac,wt,wt_exac'

                DO j = 1,Ny
                  DO k = 1,Nz
                    rms_mean(1,j) = rms_mean(1,j) + RS(1,j,k)
                    rms_mean(2,j) = rms_mean(2,j) + RS(2,j,k)
                    rms_mean(3,j) = rms_mean(3,j) + RS(3,j,k)
                    rms_mean(4,j) = rms_mean(4,j) + THS(1,j,k)

                    rms_mean(5,j) = rms_mean(5,j) + RS(4,j,k)
                    rms_mean(6,j) = rms_mean(6,j) + THS(2,j,k)
                    rms_mean(7,j) = rms_mean(7,j) + THS(3,j,k)
                    rms_mean(8,j) = rms_mean(8,j) + THS(4,j,k)
                  END DO
                    rms_mean(1:8,j) = rms_mean(1:8,j)/Nz
                    WRITE(100,"(17F15.9)") Y(j), rms_pr(1,j), rms_mean(1,j),     &
                                                 rms_pr(2,j), rms_mean(2,j),     &
                                                 rms_pr(3,j), rms_mean(3,j),     &
                                                 rms_pr(4,j), rms_mean(4,j),     &
                                                 rms_pr(5,j), rms_mean(5,j),     &
                                                 rms_pr(6,j), rms_mean(6,j),     &
                                                 rms_pr(7,j), rms_mean(7,j),     &
                                                 rms_pr(8,j), rms_mean(8,j)
                END DO
                WRITE(100,*)
                CLOSE(100)
              END IF

              !----------------------------------------------------------------!
              !                   Outputs for Eddy posoitions                  !
              !----------------------------------------------------------------!
              ! file_name = '/EDDY_POS.plt'
              ! path_name = TRIM(dir_name)//TRIM(file_name)
              !
              ! OPEN(100,FILE=path_name,FORM='FORMATTED',POSITION='APPEND')
              ! WRITE(100,*) 'VARIABLES = X,Y,Z'
              ! WRITE(100,*) 'ZONE'
              ! WRITE(100,*) 'SOLUTIONTIME =',time
              !
              ! DO it = 1,N
              !   WRITE(100,*) SEM_EDDY(it)%X_pos*10,SEM_EDDY(it)%Y_pos,          &
              !                SEM_EDDY(it)%Z_pos
              ! END DO
              ! WRITE(100,*)
              ! CLOSE(100)

              CALL CPU_TIME(time_end)

              ! WRITE(*,*) '           WRITING PROCESS IS COMPLETED            '
              ! WRITE(*,*) '  Total Writing time : ',time_end - time_sta,' s'
              ! WRITE(*,*) '----------------------------------------------------'
              ! WRITE(*,*) ''

              IF ( INT(time/dt) == Nt) THEN
                DEALLOCATE(Y,Z,U,V,W,T,RS,THS,U_INLET,V_INLET,W_INLET,T_INLET)
                DEALLOCATE(SEM_EDDY,U_COMB,V_COMB,W_COMB,T_COMB,U_pr,rms_pr,U_c)
              END IF

          END SUBROUTINE OUTPUT
