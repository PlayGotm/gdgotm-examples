GDPC                                                                               <   res://.import/ball.png-9a4ca347acb7532f6ae347744a6b04f7.stex      �       9,R ��G�������<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�
      �      ��wjN����p�c�@   res://.import/paddle.png-0e798fb0912613386507c9904d5cc01a.stex  �      �       �X*���	�0�K�ID   res://.import/separator.png-f981c8489b9148e2e1dc63398273da74.stex   �K      �       ��mja¤�b��1��   res://ball.png.import   �      �      |7*oO˺�8��q��   res://ball.tscn @	      �      �l��>����>�*   res://icon.png  �O      G      ��嗴B���,�v   res://icon.png.import   �      �      �����%��(#AB�   res://lobby.tscn0      s	      �dur_`&����qG   res://paddle.png.import P      �      ʙh �|*D%Z/0Ӽ(   res://paddle.tscn   �      �      @��տ'�q�Wj�1   res://pong.tscn �       �	      .7<�b�^��5��j�   res://project.binary�Q      )      v*ž��G����VxU   res://scripts/ball.gd.remap �N      '       w� ��0������1q   res://scripts/ball.gdc  P*      �      ���g����ڗ�QcU   res://scripts/lobby.gd.remapO      (       ���X�}��E/�e3�[   res://scripts/lobby.gdc 01      C      �ɢ(�N�B����Hu    res://scripts/paddle.gd.remap   @O      )       ��6�Fk'p���8�s   res://scripts/paddle.gdc�?      �      $y���y������   res://scripts/pong.gd.remap pO      '       �Ρ��_��7f�`KW�   res://scripts/pong.gdc  PE      [      ��G=��V���d�
   res://separator.png.import  PL      �      �g�d�t��i���G�    GDST               x   PNG �PNG

   IHDR         ���   sRGB ���   .IDAT�c���?�P�������@ �`щb"A(W�� u-�� �C�r�#    IEND�B`�            [remap]

importer="texture"
type="StreamTexture"
path="res://.import/ball.png-9a4ca347acb7532f6ae347744a6b04f7.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://ball.png"
dest_files=[ "res://.import/ball.png-9a4ca347acb7532f6ae347744a6b04f7.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
               [gd_scene load_steps=4 format=2]

[ext_resource path="res://scripts/ball.gd" type="Script" id=1]
[ext_resource path="res://ball.png" type="Texture" id=2]

[sub_resource type="CircleShape2D" id=1]
radius = 5.11969

[node name="Ball" type="Area2D"]
script = ExtResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 2 )

[node name="Shape" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )
    GDST@   @           �  PNG �PNG

   IHDR   @   @   %�   sRGB ���  VIDATh���NQ�tp����6�ǘ�������n|W����ƅ.�0�\	��\`bh�J��!]��V�t1t�+���i��l��{��8��w�� 4�P����'���'�
��ɣd�}��;;<�����cnNN�e������U�#�t����v��l5�-, ��T�g&��u �����H x59�P��Q+]��m��w�nq����D &��50�i����7 :�N$ ��5��: y��6�" j��c� O߀8����#�D &�X��r	%�B^/O܄��`O��''�K�:�� �A�@t�����M�<UU �
�D :���	~D�./8�ۅ������O܄������\�D�Z$��������-~;]OD�gb9*C�<S�сgn7���s�^��(������4g��Y6��7 ������	q=q� ���A�!�gWW<񿢪�Dnw��硪PUQ��T�8��A���oGu�Z
�|��f!uG��ڒ�%
qf�t8 |����k�i�KQ��/��|�� �2��k�Y���>O�Ċ[��H���#~?O�Q4M��Ū���t<.'��:P��ho_�~��( J��y�<��B��;�:�5��~��q`s���	}�:��v�����7~�O��m���ˉ��imڜ�Vc���N����"��p 0���+��= ��!����rȎ!��vt 8����k	�}>�&P?D
� ���k	2|3g*�;�$�n7�C��Q�z �ݪ�-�S�6�hVT�4�*��\Z≷����x:���R>߂��5����7�	�ARet    IEND�B`�    [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
[gd_scene load_steps=2 format=2]

[ext_resource path="res://scripts/lobby.gd" type="Script" id=1]

[node name="Lobby" type="Control"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = -320.0
margin_top = -200.0
margin_right = 320.0
margin_bottom = 200.0
size_flags_horizontal = 2
size_flags_vertical = 2
__meta__ = {
"_edit_use_anchors_": false
}

[node name="Title" type="Label" parent="."]
margin_left = 210.0
margin_top = 40.0
margin_right = 430.0
margin_bottom = 80.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "Multiplayer Pong"
align = 1
valign = 1

[node name="LobbyPanel" type="Panel" parent="."]
margin_left = 210.0
margin_top = 160.0
margin_right = 430.0
margin_bottom = 270.0
size_flags_horizontal = 2
size_flags_vertical = 2
script = ExtResource( 1 )
__meta__ = {
"_edit_use_anchors_": false
}

[node name="AddressLabel" type="Label" parent="LobbyPanel"]
margin_left = 10.0
margin_top = 10.0
margin_right = 62.0
margin_bottom = 24.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "Address"

[node name="Address" type="LineEdit" parent="LobbyPanel"]
margin_left = 10.0
margin_top = 30.0
margin_right = 210.0
margin_bottom = 54.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "127.0.0.1"

[node name="HostButton" type="Button" parent="LobbyPanel"]
margin_left = 10.0
margin_top = 60.0
margin_right = 90.0
margin_bottom = 80.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "Host"

[node name="JoinButton" type="Button" parent="LobbyPanel"]
margin_left = 130.0
margin_top = 60.0
margin_right = 210.0
margin_bottom = 80.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "Join"
__meta__ = {
"_edit_use_anchors_": false
}

[node name="StatusOk" type="Label" parent="LobbyPanel"]
margin_left = 10.0
margin_top = 90.0
margin_right = 210.0
margin_bottom = 104.0
size_flags_horizontal = 2
size_flags_vertical = 0
custom_colors/font_color = Color( 0, 1, 0.015625, 1 )
align = 1

[node name="StatusFail" type="Label" parent="LobbyPanel"]
margin_left = 10.0
margin_top = 90.0
margin_right = 210.0
margin_bottom = 104.0
size_flags_horizontal = 2
size_flags_vertical = 0
custom_colors/font_color = Color( 1, 0, 0, 1 )
align = 1
[connection signal="pressed" from="LobbyPanel/HostButton" to="LobbyPanel" method="_on_host_pressed"]
[connection signal="pressed" from="LobbyPanel/JoinButton" to="LobbyPanel" method="_on_join_pressed"]
             GDST                v   PNG �PNG

   IHDR          ���[   sRGB ���   ,IDAT(���!  ���sQ5T�����\U@�r�^�Q|���7�_<�I^�    IEND�B`�              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/paddle.png-0e798fb0912613386507c9904d5cc01a.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://paddle.png"
dest_files=[ "res://.import/paddle.png-0e798fb0912613386507c9904d5cc01a.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
         [gd_scene load_steps=4 format=2]

[ext_resource path="res://scripts/paddle.gd" type="Script" id=1]
[ext_resource path="res://paddle.png" type="Texture" id=2]

[sub_resource type="CapsuleShape2D" id=1]
radius = 4.78568
height = 23.6064

[node name="Paddle" type="Area2D"]
script = ExtResource( 1 )

[node name="Sprite" type="Sprite" parent="."]
texture = ExtResource( 2 )

[node name="Shape" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="You" type="Label" parent="."]
margin_left = -26.0
margin_top = -33.0
margin_right = 27.0
margin_bottom = -19.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "You"
align = 1
[connection signal="area_entered" from="." to="." method="_on_paddle_area_enter"]
     [gd_scene load_steps=5 format=2]

[ext_resource path="res://scripts/pong.gd" type="Script" id=1]
[ext_resource path="res://separator.png" type="Texture" id=2]
[ext_resource path="res://paddle.tscn" type="PackedScene" id=3]
[ext_resource path="res://ball.tscn" type="PackedScene" id=4]

[node name="Pong" type="Node2D"]
script = ExtResource( 1 )

[node name="ColorRect" type="ColorRect" parent="."]
margin_right = 640.0
margin_bottom = 400.0
color = Color( 0.141176, 0.152941, 0.164706, 1 )
__meta__ = {
"_edit_use_anchors_": false
}

[node name="Separator" type="Sprite" parent="."]
position = Vector2( 320, 200 )
texture = ExtResource( 2 )

[node name="Player1" parent="." instance=ExtResource( 3 )]
position = Vector2( 32.49, 188.622 )
left = true

[node name="Sprite" parent="Player1" index="0"]
self_modulate = Color( 0, 1, 1, 1 )

[node name="Player2" parent="." instance=ExtResource( 3 )]
self_modulate = Color( 1, 0, 1, 1 )
position = Vector2( 608.88, 188.622 )

[node name="Sprite" parent="Player2" index="0"]
self_modulate = Color( 1, 0, 1, 1 )

[node name="Ball" parent="." instance=ExtResource( 4 )]
position = Vector2( 320.387, 189.525 )

[node name="ScoreLeft" type="Label" parent="."]
margin_left = 240.0
margin_top = 10.0
margin_right = 280.0
margin_bottom = 30.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "0"
align = 1

[node name="ScoreRight" type="Label" parent="."]
margin_left = 360.0
margin_top = 10.0
margin_right = 400.0
margin_bottom = 30.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "0"
align = 1

[node name="WinnerLeft" type="Label" parent="."]
visible = false
margin_left = 190.0
margin_top = 170.0
margin_right = 267.0
margin_bottom = 184.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "The Winner!"

[node name="WinnerRight" type="Label" parent="."]
visible = false
margin_left = 380.0
margin_top = 170.0
margin_right = 457.0
margin_bottom = 184.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "The Winner!"

[node name="ExitGame" type="Button" parent="."]
visible = false
margin_left = 280.0
margin_top = 340.0
margin_right = 360.0
margin_bottom = 360.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "Exit Game"

[node name="Camera2D" type="Camera2D" parent="."]
offset = Vector2( 320, 200 )
current = true
[connection signal="pressed" from="ExitGame" to="." method="_on_exit_game_pressed"]

[editable path="Player1"]

[editable path="Player2"]
         GDSC      
   ?   0     ���ׄ�   ������������򶶶   ��������ض��   ���ⶶ��   ������Ҷ   �����Ҷ�   �����������Ӷ���   ����������������¶��   ���Ӷ���   �������Ŷ���   ����׶��   ��������Ӷ��   �������Ŷ���   �������ض���   ϶��   ����������������Ķ��   ζ��   ���������¶�   ��ն   �����Ӷ�   ���¶���   �����۶�   ���������Ҷ�   ���ƶ���   ����������ڶ   �������¶���   ����ⶶ�   d                       update_score      _reset_ball         �������?      @                                     	                           	   %   
   &      -      1      2      3      4      9      B      C      D      I      i      r      s      y      z      {      |      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3   �   4     5     6     7   	  8     9     :     ;   !  <   $  =   *  >   .  ?   3YY:�  YY;�  �  T�  Y;�  �  Y;�  �  YY5;�  �  PQT�  YY0�	  P�
  QV�  �  �
  �  �  �  �  &�  V�  �  P�  �
  �  Q�  �  �  ;�  �  �  &P�  T�  	�  �  T�  	�  QP�  T�  �  T�  �  T�  �  QV�  �  T�  �  T�  �  �  &�  PQV�  �  �  �  &�  T�  	�  V�  �  PQT�  P�  R�  Q�  �  P�  R�  Q�  (V�  �  �  �  &�  T�  �  T�  V�  �  PQT�  P�  R�  Q�  �  P�  R�  QYYYE0�  P�  R�  QV�  �  &�  V�  �  T�  �  P�  T�  Q�  (V�  �  T�  �  P�  T�  Q�  �  �  �  �  �  T�  �  �  �  �  �  �  T�  PQYYYE0�  PQV�  �  �  YYYE0�  P�  QV�  �  �  �	  �  &�  V�  �  �  T�  �  (V�  �  �  T�  �  �  �  Y`GDSC   6      m        ������ڶ   �����������ⶶ��   ������Ŷ   ������Ŷ   ����������ض   ���������ض�   ����������ض   ���������ض�   ��������ݶ��   �������ݶ���   ����������ڶ   ���������ڶ�   �����϶�   �������Ӷ���   ������¶   ����������������Ҷ��   ��Ҷ   ���Ѷ���   �������Ӷ���   ���������������򶶶�   �������¶���   ��������Ҷ��   ���Ӷ���   �������������������Ҷ���   ����������������Ķ��   ��������Ӷ��   ������������ݶ��   ��������������ڶ   ����������Ŷ   ���������������Ķ���   �����������Ҷ���   �������������������Ҷ���   ���������Ķ�   �������Ӷ���   �������Ӷ���   ���Ӷ���   ��������   ���¶���   ���ݶ���   �������¶���   ���������������Ҷ���   ���¶���   �����������������������¶���   ����   �������������������Ӷ���   �������������������䶶��   ��Ķ   ������������Ķ��   ����   ���������������Ҷ���   �ƶ�   �������¶���   ������������������Ŷ   ������������¶��   �"        network_peer_connected        _player_connected         network_peer_disconnected         _player_disconnected      connected_to_server       _connected_ok         connection_failed         _connected_fail       server_disconnected       _server_disconnected      res://pong.tscn       game_finished      	   _end_game         Client disconnected       Server disconnected       Couldn't connect                     
   /root/Pong              Can't host, address in use.       Waiting for player...               IP address is invalid         Connecting...                            	                        %   	   ,   
   -      3      4      A      N      [      h      u      v      w      x      y      �      �      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3     4     5     6     7     8     9     :     ;     <   $  =   %  >   .  ?   2  @   3  A   <  B   C  C   J  D   K  E   R  F   S  G   T  H   ]  I   ^  J   b  K   i  L   p  M   s  N   z  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^   �  _   �  `   �  a   �  b   �  c   �  d   �  e   �  f   �  g   �  h      i   	  j     k     l     m   3YY:�  YY5;�  W�  Y5;�  W�  Y5;�  W�  Y5;�  W�	  Y5;�
  W�  YY0�  PQV�  �  �  PQT�  P�  RR�  Q�  �  PQT�  P�  RR�  Q�  �  PQT�  P�  RR�  Q�  �  PQT�  P�  RR�  Q�  �  PQT�  P�	  RR�
  QYYYYY0�  P�  QV�  �  ;�  �L  P�  QT�  PQ�  �  �  T�  P�  RR�  RLMR�  Q�  �  �  PQT�  PQT�  P�  Q�  �  PQYYY0�  P�  QV�  &�  PQT�  PQV�  �  P�  Q�  (V�  �  P�  QYYYY0�  PQV�  -YYYY0�  PQV�  �  P�  R�  Q�  �  �  PQT�  P�  Q�  �  �  T�  P�  Q�  �  T�  P�  QYYY0�  PQV�  �  P�  QYYYY0�  P�   �  QV�  &�!  P�  QV�  �  �"  P�  QT�#  PQ�  �$  PQ�  �  �  PQT�  P�  Q�  �  T�  P�  Q�  �  T�  P�  Q�  �  �  P�   R�  QYYY0�  P�%  R�&  QV�  �  &�&  V�  �  T�'  P�%  Q�  �
  T�'  P�  Q�  (V�  �  T�'  P�  Q�  �
  T�'  P�%  QYYY0�(  PQV�  ;�)  �*  T�+  PQ�  �)  T�,  P�*  T�-  Q�  ;�.  �)  T�/  P�  R�  Q�  &�.  �0  V�  �  �  P�  R�  Q�  .�  �  �  PQT�  P�)  Q�  �  �  �  P�  R�  QYYY0�1  PQV�  ;�2  �  T�3  PQ�  &�2  T�4  PQV�  �  P�  R�  Q�  .�  �  ;�)  �*  T�+  PQ�  �)  T�,  P�*  T�-  Q�  �)  T�5  P�2  R�  Q�  �  PQT�  P�)  Q�  �  �  P�  R�  QY`             GDSC      
   2   �      ���ׄ�   �����������򶶶�   ���¶���   �����ض�   ���������ض�   �������������϶�   ����������������¶��   ���Ӷ���   ϶��   �������Ŷ���   ����׶��   ����������������Ķ��   ����¶��   ������������������޶   ��������������ڶ   �������������Ӷ�   �������ض���   ��������Ӷ��   �����������������ض�   ����Ŷ��   �������ض���   �������Ӷ���   ���Ӷ���   ��������������������Ķ��   ���׶���   ��ն   �                    	   move_down         move_up       set_pos_and_motion                    You       bounce                           	                           	      
   '      (      /      0      6      F      G      P      T      U      Y      Z      [      \      e      h      m      q      r      ~            �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   3YY:�  YY8;�  �  YY;�  �  Y;�  �  YY5;�  �  PQT�  T�  YY0�	  P�
  QV�  �  &�  PQV�  �  �  T�  P�  Q�  T�  P�  Q�  �  &�  �  �  V�  �  PQ�  �  �  �  �  �  �  �  �  P�  R�  R�  Q�  (V�  &�  V�  �  PQ�  �  �  P�  P�  R�  �
  QQ�  �  �  �  T�  �5  P�  T�  R�  R�  �  QYYYYH0�  P�  R�  QV�  �  �  �  �  �  YYY0�  PQV�  �  �  �  �  P�  QT�  PQYYY0�  P�  QV�  &�  PQV�  �  �  T�  P�	  R�  R�'  PQQY`        GDSC         4   �      ���ӄ�   ����������������   ���������¶�   ����������¶   ������������Ҷ��   �����Ą�   �����Ą�   ��������������Ӷ   ��������¶��   ���������������Ӷ���   ���������¶�   ����������¶   ���������¶�   �����������¶���   ����������¶   �����϶�   �������Ӷ���   ����������������Ķ��   �����������������Ķ�   ��������������������������Ŷ   ��������������������Ҷ��   �����������Ӷ���   ����������¶   �������¶���   ���������Ҷ�   ��������   �������Ӷ���   ���ڶ���   ��ն   ��������������������Ҷ��   ����������ڶ   
                unique id:                           stop      game_finished                            	                           	      
   !      (      /      6      =      >      D      E      F      G      Q      R      b      e      f      s      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3   �   4   3YY:�  YY;�  �  Y;�  �  YYB�  PQYY5;�  W�  Y5;�  W�  Y5;�	  W�
  Y5;�  W�  Y5;�  W�  YY0�  PQV�  �  �  �  &�  PQT�  PQV�  �  �  T�  P�  PQT�  PQL�  MQ�  (V�  �  �  T�  P�  PQT�  PQQ�  �?  P�  R�  PQT�  PQQYYYE0�  P�  QV�  &�  V�  �  �  �  �  T�  P�>  P�  QQ�  (V�  �  �  �  �	  T�  P�>  P�  QQ�  �  ;�  �  �  &�  �  V�  �  T�  PQ�  �  �  �  '�  �  V�  �  T�  PQ�  �  �  �  �  &�  V�  W�  T�  PQ�  W�  T�  P�  QYYY0�  PQV�  �  P�  QY`     GDST   �           {   PNG �PNG

   IHDR     �   �o��   sRGB ���   1IDATH��ʱ�0�09��/�K�~PP���ݪN�����a�a�a�W���k�&Q�    IEND�B`�         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/separator.png-f981c8489b9148e2e1dc63398273da74.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://separator.png"
dest_files=[ "res://.import/separator.png-f981c8489b9148e2e1dc63398273da74.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
[remap]

path="res://scripts/ball.gdc"
         [remap]

path="res://scripts/lobby.gdc"
        [remap]

path="res://scripts/paddle.gdc"
       [remap]

path="res://scripts/pong.gdc"
         �PNG

   IHDR   @   @   ����   	pHYs     ��   �PLTE   ��ͽ��  �� yy	& �� �� �����ĥ�4������;������=������:���δ�#1� �ä�!��鼛�		  55 ����һ��������0���,,,���̱�:���ҭ�������KK��������

<���ս�"5ƨ�"��󾝝�>>lؑ�   bKGDKi�P   �IDATx��MQ���̆?ad#%J���bl}$$��bK+�P���,HfNw&���uO�}�sν���R\?`h�T��o�݀$��8o�g�pҐĽ�b�3}"@`N@?R�����zhН[
Ȳ��F�(�~g��T`Κrp����q&�� ��`M ��QPV�Qf쥑^���JsPeBsj�}xy\_�5 ��@[f���@�a�M4\u /�Y��{�H��B+�*4��:�n5?1n]v    IEND�B`�         ECFG      _global_script_classes             _global_script_class_icons             application/config/name         Pong Multiplayer   application/config/description�      �   A multiplayer demo of the classical pong game.
One of the players should press 'host', while the
other should select the address and press 'join'.     application/run/main_scene         res://lobby.tscn   application/config/icon         res://icon.png  .   debug/gdscript/warnings/return_value_discarded             display/window/size/width      �     display/window/size/height      �     display/window/stretch/mode         2d     display/window/stretch/aspect         expand     display/stretch_2d            gdnative/singletons             input/move_down(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       �?   script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   Z      unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   S      unicode           echo          script         input/move_up(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       ��   script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   W      unicode           echo          script      $   rendering/quality/driver/driver_name         GLES2   #   rendering/quality/2d/use_pixel_snap         &   rendering/viewport/default_clear_color                    �?       