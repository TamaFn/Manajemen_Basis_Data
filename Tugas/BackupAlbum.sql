PGDMP     4                     {            Album_Database    15.2    15.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    17114    Album_Database    DATABASE     �   CREATE DATABASE "Album_Database" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE "Album_Database";
                postgres    false            �            1259    17125    album    TABLE     �   CREATE TABLE public.album (
    singerid character varying(5) NOT NULL,
    albumno character varying(5) NOT NULL,
    albumname character varying(50) NOT NULL,
    releaseyear integer NOT NULL,
    price numeric(10,2) NOT NULL
);
    DROP TABLE public.album;
       public         heap    postgres    false                       0    0    TABLE album    ACL     s   GRANT SELECT ON TABLE public.album TO admin_toko;
GRANT SELECT,INSERT,UPDATE ON TABLE public.album TO admin_album;
          public          postgres    false    216            �            1259    17135 
   detailitem    TABLE     �   CREATE TABLE public.detailitem (
    detailid character varying(10) NOT NULL,
    albumno character varying(5) NOT NULL,
    receiptno character varying(10) NOT NULL,
    amount integer NOT NULL,
    totalprice numeric(10,2) NOT NULL
);
    DROP TABLE public.detailitem;
       public         heap    postgres    false                       0    0    TABLE detailitem    ACL     E   GRANT SELECT,INSERT,UPDATE ON TABLE public.detailitem TO admin_toko;
          public          postgres    false    217            �            1259    17120    receipt    TABLE     �   CREATE TABLE public.receipt (
    receiptno character varying(10) NOT NULL,
    costumername character varying(50) NOT NULL,
    receiptdate date NOT NULL
);
    DROP TABLE public.receipt;
       public         heap    postgres    false                       0    0    TABLE receipt    ACL     B   GRANT SELECT,INSERT,UPDATE ON TABLE public.receipt TO admin_toko;
          public          postgres    false    215            �            1259    17115    singer    TABLE     z   CREATE TABLE public.singer (
    singerid character varying(5) NOT NULL,
    singername character varying(50) NOT NULL
);
    DROP TABLE public.singer;
       public         heap    postgres    false                       0    0    TABLE singer    ACL     u   GRANT SELECT ON TABLE public.singer TO admin_toko;
GRANT SELECT,INSERT,UPDATE ON TABLE public.singer TO admin_album;
          public          postgres    false    214                      0    17125    album 
   TABLE DATA           Q   COPY public.album (singerid, albumno, albumname, releaseyear, price) FROM stdin;
    public          postgres    false    216                    0    17135 
   detailitem 
   TABLE DATA           V   COPY public.detailitem (detailid, albumno, receiptno, amount, totalprice) FROM stdin;
    public          postgres    false    217   �       
          0    17120    receipt 
   TABLE DATA           G   COPY public.receipt (receiptno, costumername, receiptdate) FROM stdin;
    public          postgres    false    215          	          0    17115    singer 
   TABLE DATA           6   COPY public.singer (singerid, singername) FROM stdin;
    public          postgres    false    214   t       u           2606    17129    album album_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (albumno);
 :   ALTER TABLE ONLY public.album DROP CONSTRAINT album_pkey;
       public            postgres    false    216            w           2606    17139    detailitem detailitem_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.detailitem
    ADD CONSTRAINT detailitem_pkey PRIMARY KEY (detailid);
 D   ALTER TABLE ONLY public.detailitem DROP CONSTRAINT detailitem_pkey;
       public            postgres    false    217            s           2606    17124    receipt receipt_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.receipt
    ADD CONSTRAINT receipt_pkey PRIMARY KEY (receiptno);
 >   ALTER TABLE ONLY public.receipt DROP CONSTRAINT receipt_pkey;
       public            postgres    false    215            q           2606    17119    singer singer_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.singer
    ADD CONSTRAINT singer_pkey PRIMARY KEY (singerid);
 <   ALTER TABLE ONLY public.singer DROP CONSTRAINT singer_pkey;
       public            postgres    false    214            x           2606    17130    album album_singerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_singerid_fkey FOREIGN KEY (singerid) REFERENCES public.singer(singerid);
 C   ALTER TABLE ONLY public.album DROP CONSTRAINT album_singerid_fkey;
       public          postgres    false    216    3185    214            y           2606    17140 "   detailitem detailitem_albumno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailitem
    ADD CONSTRAINT detailitem_albumno_fkey FOREIGN KEY (albumno) REFERENCES public.album(albumno);
 L   ALTER TABLE ONLY public.detailitem DROP CONSTRAINT detailitem_albumno_fkey;
       public          postgres    false    3189    217    216            z           2606    17145 $   detailitem detailitem_receiptno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailitem
    ADD CONSTRAINT detailitem_receiptno_fkey FOREIGN KEY (receiptno) REFERENCES public.receipt(receiptno);
 N   ALTER TABLE ONLY public.detailitem DROP CONSTRAINT detailitem_receiptno_fkey;
       public          postgres    false    215    3187    217               �   x�M�M� ���p
`���%�I%m��!����C@M\|��{*�m��i����dШn�3"N�"��K�Si@#��}A�����$��������~ނ�2W.�N](p��� ��R�h0�yMB�7Z'<         R   x�M��	�0��=LPl�M��L�w���"��!�����̵B����6�m4�ԄNl������˲��\���?|������      
   _   x�M�1
�0�99E/��Qp��J��Ct�x�s(.:��"���^j��ьTT���D�g(��R8�����p؆��Q�5|ay�L5����F�kd�1[]      	   =   x�s20�t�t�sTpr�sq���x;zx��9ry�N!�N\�@����K��c$W� z��     