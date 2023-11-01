module fstock_page_test
   use, intrinsic :: iso_c_binding
   use gtk
   use g

   use fstock_page_home

   implicit none
   type(c_ptr) :: window_ref
contains

   subroutine test_bnt1_clicked(widget, gdata) bind(c)
      type(c_ptr), value, intent(in) :: widget, gdata
      print *, "Button clicked!", gdata

      call fstock_page_home_show(window_ref)
   end subroutine test_bnt1_clicked

   subroutine fstock_page_test_show(window) bind(c)
      type(c_ptr), value, intent(in) :: window
      type(c_ptr) :: box, btn

      window_ref = window


      box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0_c_int)

      btn = gtk_button_new_with_label("Button 1")
      call g_signal_connect(btn, "clicked"//c_null_char, c_funloc(test_bnt1_clicked), c_null_ptr)
      call gtk_box_append(box, btn)


      call gtk_window_set_child(window, box)
      call gtk_widget_show(window)

   end subroutine fstock_page_test_show

end module fstock_page_test
