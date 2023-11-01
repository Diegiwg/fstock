module handlers
   use, intrinsic :: iso_c_binding
   use gtk
   use g, only : g_application_run, g_object_unref

   use fstock_page_home

   implicit none

   type(c_ptr) :: window
contains

   subroutine activate(app, gdata) bind(c)
      type(c_ptr), value, intent(in) :: app, gdata
      type(c_ptr) :: btn1, btn2

      window = gtk_application_window_new(app)
      call gtk_window_set_title(window, "FStock Application"//c_null_char)
      call gtk_window_set_default_size(window, 400_c_int, 300_c_int)

      call fstock_page_home_show(window)
   end subroutine activate



end module handlers


program main
   use handlers
   implicit none

   type(c_ptr) :: app
   integer(c_int) :: status

   app = gtk_application_new("fstock.app"//c_null_char, &
   & G_APPLICATION_FLAGS_NONE)

   call g_signal_connect(app, "activate"//c_null_char, c_funloc(activate), c_null_ptr)

   status = g_application_run(app, 0_c_int, [c_null_ptr])
   print *, "Exiting with status ", status

   call g_object_unref(app)
end program main
