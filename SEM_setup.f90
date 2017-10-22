!------------------------------------------------------------------------------!
!                                                                              !
!   PROGRAM : SEM_setup.f90                                                    !
!                                                                              !
!   PURPOSE : Setup for SEM inflow generator                                   !
!                                                                              !
!                                                             2017.03.02 K.Noh !
!                                                                              !
!------------------------------------------------------------------------------!

        SUBROUTINE SETUP

            USE SEM_module,                                                     &
              ONLY : N, Ny, Nz, Nt, dt, SIGMA, V_b, file_name, dir_name, OUT_NUM

            USE SEM_module,                                                     &
              ONLY : Y, Z, U, V, W, T, RS, THS, U_INLET, V_INLET, W_INLET,      &
                      SEM_EDDY, U_COMB, V_COMB, W_COMB, U_pr, rms_pr, U_c,      &
                      T_INLET, T_COMB, eps

            IMPLICIT NONE

            !------------------------------------------------------------------!
            !                  Make & Initialize Result folder                 !
            !------------------------------------------------------------------!
            dir_name  = 'RESULT'
            CALL SYSTEM('mkdir '//TRIM(dir_name))
            CALL SYSTEM('rm -rf ./'//TRIM(dir_name)//'/*.plt')

            !------------------------------------------------------------------!
            !                         Constants for SEM                        !
            !------------------------------------------------------------------!
            N  = 1000
            Ny = 65
            Nz = 66

            Nt    = 30000
            dt    = 2e-1
            SIGMA = 13.00

            OUT_NUM = 1

            eps = 1e-8

            !------------------------------------------------------------------!
            !                         Allocate variables                       !
            !------------------------------------------------------------------!
            ALLOCATE( Y(1:Ny),Z(1:Nz) )
            ALLOCATE( U(1:Ny,1:Nz), V(1:Ny,1:Nz), W(1:Ny,1:Nz), T(1:Ny,1:Nz) )
            ALLOCATE( U_INLET(1:Ny,1:Nz),V_INLET(1:Ny,1:Nz),W_INLET(1:Ny,1:Nz) )
            ALLOCATE( U_COMB(1:Ny,1:Nz),V_COMB(1:Ny,1:Nz),W_COMB(1:Ny,1:Nz) )
            ALLOCATE( T_INLET(1:Ny,1:Nz), T_COMB(1:Ny,1:Nz)  )
            ALLOCATE( RS(6,1:Ny,1:Nz), THS(4,1:Ny,1:Nz), U_c(1:Ny,1:Nz) )
            ALLOCATE( SEM_EDDY(1:N), U_pr(4,1:Nz), rms_pr(10,1:Nz) )

            !------------------------------------------------------------------!
            !                         Initial Conditions                       !
            !------------------------------------------------------------------!
            Y(1:Ny) = 0.0
            Z(1:Nz) = 0.0

            U(1:Ny,1:Nz) = 0.0
            V(1:Ny,1:Nz) = 0.0
            W(1:Ny,1:Nz) = 0.0
            T(1:Ny,1:Nz) = 0.0

            RS(1:6,1:Ny,1:Nz) = 0.0
            THS(1:4,1:Ny,1:Nz) = 0.0

            U_INLET(1:Ny,1:Nz) = 0.0
            V_INLET(1:Ny,1:Nz) = 0.0
            W_INLET(1:Ny,1:Nz) = 0.0
            T_INLET(1:Ny,1:Nz) = 0.0

            U_COMB(1:Ny,1:Nz) = 0.0
            V_COMB(1:Ny,1:Nz) = 0.0
            W_COMB(1:Ny,1:Nz) = 0.0
            T_COMB(1:Ny,1:Nz) = 0.0

            U_c(1:Ny,1:Nz)   = 0.0
            U_pr(1:4,1:Ny)   = 0.0
            rms_pr(1:10,1:Ny) = 0.0

            SEM_EDDY(1:N)%eddy_num = 0
            SEM_EDDY(1:N)%eddy_len = 0.0
            SEM_EDDY(1:N)%X_pos    = 0.0
            SEM_EDDY(1:N)%Y_pos    = 0.0
            SEM_EDDY(1:N)%Z_pos    = 0.0
            SEM_EDDY(1:N)%X_int    = 0.0
            SEM_EDDY(1:N)%Y_int    = 0.0
            SEM_EDDY(1:N)%Z_int    = 0.0
            SEM_EDDY(1:N)%T_int    = 0.0

        END SUBROUTINE SETUP
