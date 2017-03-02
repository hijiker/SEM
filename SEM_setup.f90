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
              ONLY : N, Ny, Nz, Nt, dt, SIGMA, V_b, file_name, dir_name

            USE SEM_module,                                                     &
              ONLY : Y, Z, U, V, W, RS

            IMPLICIT NONE
            !------------------------------------------------------------------!
            !                  Make & Initialize Result folder                 !
            !------------------------------------------------------------------!
            file_name = 'SLICE.plt'
            dir_name  = 'DATA'

            !------------------------------------------------------------------!
            !                         Constants for SEM                        !
            !------------------------------------------------------------------!
            Ny = 128
            Nz = 159

            dt    = 5e-3
            SIGMA = 0.20
            Nt    = 1000

            !------------------------------------------------------------------!
            !                         Allocate variables                       !
            !------------------------------------------------------------------!
            ALLOCATE( Y(1:Ny),Z(1:Nz) )
            ALLOCATE( U(1:Ny,1:Nz), V(1:Ny,1:Nz), W(1:Ny,1:Nz) )
            ALLOCATE( RS(6,1:Ny,1:Nz) )

        END SUBROUTINE SETUP
