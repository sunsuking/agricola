create table if not exists public.django_migrations
(
    id      bigint generated by default as identity
        primary key,
    app     varchar(255)             not null,
    name    varchar(255)             not null,
    applied timestamp with time zone not null
);

alter table public.django_migrations
    owner to postgres;

create table if not exists public.django_content_type
(
    id        integer generated by default as identity
        primary key,
    app_label varchar(100) not null,
    model     varchar(100) not null,
    constraint django_content_type_app_label_model_76bd3d3b_uniq
        unique (app_label, model)
);

alter table public.django_content_type
    owner to postgres;

create table if not exists public.auth_permission
(
    id              integer generated by default as identity
        primary key,
    name            varchar(255) not null,
    content_type_id integer      not null
        constraint auth_permission_content_type_id_2f476e4b_fk_django_co
            references public.django_content_type
            deferrable initially deferred,
    codename        varchar(100) not null,
    constraint auth_permission_content_type_id_codename_01ab375a_uniq
        unique (content_type_id, codename)
);

alter table public.auth_permission
    owner to postgres;

create index if not exists auth_permission_content_type_id_2f476e4b
    on public.auth_permission (content_type_id);

create table if not exists public.auth_group
(
    id   integer generated by default as identity
        primary key,
    name varchar(150) not null
        unique
);

alter table public.auth_group
    owner to postgres;

create index if not exists auth_group_name_a6ea08ec_like
    on public.auth_group (name varchar_pattern_ops);

create table if not exists public.auth_group_permissions
(
    id            bigint generated by default as identity
        primary key,
    group_id      integer not null
        constraint auth_group_permissions_group_id_b120cbf9_fk_auth_group_id
            references public.auth_group
            deferrable initially deferred,
    permission_id integer not null
        constraint auth_group_permissio_permission_id_84c5c92e_fk_auth_perm
            references public.auth_permission
            deferrable initially deferred,
    constraint auth_group_permissions_group_id_permission_id_0cd325b0_uniq
        unique (group_id, permission_id)
);

alter table public.auth_group_permissions
    owner to postgres;

create index if not exists auth_group_permissions_group_id_b120cbf9
    on public.auth_group_permissions (group_id);

create index if not exists auth_group_permissions_permission_id_84c5c92e
    on public.auth_group_permissions (permission_id);

create table if not exists public.auth_user
(
    id           integer generated by default as identity
        primary key,
    password     varchar(128)             not null,
    last_login   timestamp with time zone,
    is_superuser boolean                  not null,
    username     varchar(150)             not null
        unique,
    first_name   varchar(150)             not null,
    last_name    varchar(150)             not null,
    email        varchar(254)             not null,
    is_staff     boolean                  not null,
    is_active    boolean                  not null,
    date_joined  timestamp with time zone not null
);

alter table public.auth_user
    owner to postgres;

create index if not exists auth_user_username_6821ab7c_like
    on public.auth_user (username varchar_pattern_ops);

create table if not exists public.auth_user_groups
(
    id       bigint generated by default as identity
        primary key,
    user_id  integer not null
        constraint auth_user_groups_user_id_6a12ed8b_fk_auth_user_id
            references public.auth_user
            deferrable initially deferred,
    group_id integer not null
        constraint auth_user_groups_group_id_97559544_fk_auth_group_id
            references public.auth_group
            deferrable initially deferred,
    constraint auth_user_groups_user_id_group_id_94350c0c_uniq
        unique (user_id, group_id)
);

alter table public.auth_user_groups
    owner to postgres;

create index if not exists auth_user_groups_user_id_6a12ed8b
    on public.auth_user_groups (user_id);

create index if not exists auth_user_groups_group_id_97559544
    on public.auth_user_groups (group_id);

create table if not exists public.auth_user_user_permissions
(
    id            bigint generated by default as identity
        primary key,
    user_id       integer not null
        constraint auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id
            references public.auth_user
            deferrable initially deferred,
    permission_id integer not null
        constraint auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm
            references public.auth_permission
            deferrable initially deferred,
    constraint auth_user_user_permissions_user_id_permission_id_14a6b632_uniq
        unique (user_id, permission_id)
);

alter table public.auth_user_user_permissions
    owner to postgres;

create index if not exists auth_user_user_permissions_user_id_a95ead1b
    on public.auth_user_user_permissions (user_id);

create index if not exists auth_user_user_permissions_permission_id_1fbb5f2c
    on public.auth_user_user_permissions (permission_id);

create table if not exists public.django_admin_log
(
    id              integer generated by default as identity
        primary key,
    action_time     timestamp with time zone not null,
    object_id       text,
    object_repr     varchar(200)             not null,
    action_flag     smallint                 not null
        constraint django_admin_log_action_flag_check
            check (action_flag >= 0),
    change_message  text                     not null,
    content_type_id integer
        constraint django_admin_log_content_type_id_c4bce8eb_fk_django_co
            references public.django_content_type
            deferrable initially deferred,
    user_id         integer                  not null
        constraint django_admin_log_user_id_c564eba6_fk_auth_user_id
            references public.auth_user
            deferrable initially deferred
);

alter table public.django_admin_log
    owner to postgres;

create index if not exists django_admin_log_content_type_id_c4bce8eb
    on public.django_admin_log (content_type_id);

create index if not exists django_admin_log_user_id_c564eba6
    on public.django_admin_log (user_id);

create table if not exists public.django_session
(
    session_key  varchar(40)              not null
        primary key,
    session_data text                     not null,
    expire_date  timestamp with time zone not null
);

alter table public.django_session
    owner to postgres;

create index if not exists django_session_session_key_c0390e0f_like
    on public.django_session (session_key varchar_pattern_ops);

create index if not exists django_session_expire_date_a5c62663
    on public.django_session (expire_date);

create table if not exists public.accounts_user
(
    id           bigint generated by default as identity
        primary key,
    password     varchar(128)             not null,
    last_login   timestamp with time zone,
    is_superuser boolean                  not null,
    username     varchar(150)             not null
        unique,
    first_name   varchar(150)             not null,
    last_name    varchar(150)             not null,
    email        varchar(254)             not null,
    is_staff     boolean                  not null,
    is_active    boolean                  not null,
    date_joined  timestamp with time zone not null
);

alter table public.accounts_user
    owner to postgres;

create index if not exists accounts_user_username_6088629e_like
    on public.accounts_user (username varchar_pattern_ops);

create table if not exists public.accounts_user_groups
(
    id       bigint generated by default as identity
        primary key,
    user_id  bigint  not null
        constraint accounts_user_groups_user_id_52b62117_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred,
    group_id integer not null
        constraint accounts_user_groups_group_id_bd11a704_fk_auth_group_id
            references public.auth_group
            deferrable initially deferred,
    constraint accounts_user_groups_user_id_group_id_59c0b32f_uniq
        unique (user_id, group_id)
);

alter table public.accounts_user_groups
    owner to postgres;

create index if not exists accounts_user_groups_user_id_52b62117
    on public.accounts_user_groups (user_id);

create index if not exists accounts_user_groups_group_id_bd11a704
    on public.accounts_user_groups (group_id);

create table if not exists public.accounts_user_user_permissions
(
    id            bigint generated by default as identity
        primary key,
    user_id       bigint  not null
        constraint accounts_user_user_p_user_id_e4f0a161_fk_accounts_
            references public.accounts_user
            deferrable initially deferred,
    permission_id integer not null
        constraint accounts_user_user_p_permission_id_113bb443_fk_auth_perm
            references public.auth_permission
            deferrable initially deferred,
    constraint accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq
        unique (user_id, permission_id)
);

alter table public.accounts_user_user_permissions
    owner to postgres;

create index if not exists accounts_user_user_permissions_user_id_e4f0a161
    on public.accounts_user_user_permissions (user_id);

create index if not exists accounts_user_user_permissions_permission_id_113bb443
    on public.accounts_user_user_permissions (permission_id);

create table if not exists public.accounts_userconfig
(
    id          bigint generated by default as identity
        primary key,
    "isInvited" boolean not null,
    "isMuted"   boolean not null,
    user_id     bigint  not null
        unique
        constraint accounts_userconfig_user_id_9941dffb_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.accounts_userconfig
    owner to postgres;

create table if not exists public.accounts_profile
(
    id          bigint generated by default as identity
        primary key,
    nickname    varchar(100)             not null,
    avatar      varchar(100)             not null,
    plays       integer                  not null,
    wins        integer                  not null,
    loses       integer                  not null,
    "createdAt" timestamp with time zone not null,
    "updatedAt" timestamp with time zone not null,
    user_id     bigint                   not null
        unique
        constraint accounts_profile_user_id_49a85d32_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.accounts_profile
    owner to postgres;

create table if not exists public.accounts_friend
(
    id        bigint generated by default as identity
        primary key,
    friend_id bigint not null
        constraint accounts_friend_friend_id_e7752edd_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred,
    user_id   bigint not null
        constraint accounts_friend_user_id_d922c6b2_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.accounts_friend
    owner to postgres;

create index if not exists accounts_friend_friend_id_e7752edd
    on public.accounts_friend (friend_id);

create index if not exists accounts_friend_user_id_d922c6b2
    on public.accounts_friend (user_id);

create table if not exists public.cards_card
(
    id          bigint generated by default as identity
        primary key,
    card_number varchar(16)  not null
        constraint cards_card_card_number_ef7d3d1b_uniq
            unique,
    card_type   varchar(10)  not null,
    name        varchar(255) not null,
    score       integer      not null,
    command     varchar(200) not null
);

alter table public.cards_card
    owner to postgres;

create index if not exists cards_card_card_number_ef7d3d1b_like
    on public.cards_card (card_number varchar_pattern_ops);

create table if not exists public.games_room
(
    id         bigint generated by default as identity
        primary key,
    name       varchar(255) not null,
    mode       varchar(255) not null,
    password   varchar(255) not null,
    creator_id bigint       not null
        constraint games_room_creator_id_0563c064_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.games_room
    owner to postgres;

create table if not exists public.games_gameresult
(
    id          bigint generated by default as identity
        primary key,
    "createdAt" timestamp with time zone not null,
    finished    timestamp with time zone not null,
    room_id     bigint                   not null
        constraint games_gameresult_room_id_b472bebe_fk_games_room_id
            references public.games_room
            deferrable initially deferred,
    winner_id   bigint                   not null
        constraint games_gameresult_winner_id_beec62f9_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.games_gameresult
    owner to postgres;

create index if not exists games_gameresult_room_id_b472bebe
    on public.games_gameresult (room_id);

create index if not exists games_gameresult_winner_id_beec62f9
    on public.games_gameresult (winner_id);

create index if not exists games_room_creator_id_0563c064
    on public.games_room (creator_id);

create table if not exists public.games_gameresultdetail
(
    id      bigint generated by default as identity
        primary key,
    score   integer not null,
    game_id bigint  not null
        constraint games_gameresultdetail_game_id_6d5e156a_fk_games_gameresult_id
            references public.games_gameresult
            deferrable initially deferred,
    user_id bigint  not null
        constraint games_gameresultdetail_user_id_9f257818_fk_accounts_user_id
            references public.accounts_user
            deferrable initially deferred
);

alter table public.games_gameresultdetail
    owner to postgres;

create index if not exists games_gameresultdetail_game_id_6d5e156a
    on public.games_gameresultdetail (game_id);

create index if not exists games_gameresultdetail_user_id_9f257818
    on public.games_gameresultdetail (user_id);

create table if not exists public.django_site
(
    id     integer generated by default as identity
        primary key,
    domain varchar(100) not null
        constraint django_site_domain_a2e37b91_uniq
            unique,
    name   varchar(50)  not null
);

alter table public.django_site
    owner to postgres;

create index if not exists django_site_domain_a2e37b91_like
    on public.django_site (domain varchar_pattern_ops);
