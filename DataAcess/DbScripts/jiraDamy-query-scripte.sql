USE [taskDatabase]
GO
/****** Object:  UserDefinedTableType [dbo].[AddMembers]    Script Date: 24-08-2022 09:40:03 ******/
CREATE TYPE [dbo].[AddMembers] AS TABLE(
	[userID] [int] NULL
)
GO
/****** Object:  Table [dbo].[ActionAccess]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionAccess](
	[RoleId] [int] NOT NULL,
	[ActionId] [int] NOT NULL,
 CONSTRAINT [PK_ActionAccess] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[ActionId] [int] NOT NULL,
	[ControllerName] [char](25) NULL,
	[ActionName] [char](25) NULL,
	[ShowInSideBar] [bit] NULL,
	[DisplayName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Actions__FFE3F4D9B7DED1C3] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTable]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTable](
	[statusID] [int] NOT NULL,
	[statusName] [nchar](10) NULL,
 CONSTRAINT [PK_statusTable] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskDataTable]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskDataTable](
	[taskId] [int] IDENTITY(1,1) NOT NULL,
	[taskName] [varchar](50) NULL,
	[taskStatus] [int] NULL,
	[description] [varchar](100) NULL,
	[assigneeId] [int] NULL,
 CONSTRAINT [PK_taskDataTable] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMembers]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMembers](
	[TeamMemberId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
 CONSTRAINT [PK_TeamMembers] PRIMARY KEY CLUSTERED 
(
	[TeamMemberId] ASC,
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamID] [int] NOT NULL,
	[TeamName] [nchar](10) NULL,
	[TeamLeder] [int] NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 1)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 2)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 3)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 4)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 5)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 6)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 7)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 1)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 4)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 7)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 2)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 3)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 4)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 5)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 6)
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (1, N'Authentication           ', N'SignUp                   ', 1, N'Add User')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (2, N'Authentication           ', N'LogIn                    ', 0, N'Log In')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (3, N'Home                     ', N'AddTask                  ', 1, N'Add New Task')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (4, N'Home                     ', N'Todo                     ', 1, N'Show Todo Task')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (5, N'Home                     ', N'Active                   ', 1, N'Show Active Task')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (6, N'Home                     ', N'Completed                ', 1, N'Show Completed Task')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (7, N'Home                     ', N'CreateTeam               ', 1, N'Add New Team')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'HR')
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'User')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (1, N'Todo      ')
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (2, N'Active    ')
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (3, N'completed ')
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (1, N'Sagar', N'123', 1, N'Sagar', N'Gavand', NULL, NULL)
ALTER TABLE [dbo].[ActionAccess]  WITH CHECK ADD  CONSTRAINT [FK__ActionAcc__Actio__4BAC3F29] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([ActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionAccess] CHECK CONSTRAINT [FK__ActionAcc__Actio__4BAC3F29]
GO
ALTER TABLE [dbo].[ActionAccess]  WITH CHECK ADD  CONSTRAINT [FK__ActionAcc__RoleI__4AB81AF0] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionAccess] CHECK CONSTRAINT [FK__ActionAcc__RoleI__4AB81AF0]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role] FOREIGN KEY([Id])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role]
GO
ALTER TABLE [dbo].[TaskDataTable]  WITH CHECK ADD  CONSTRAINT [FK_taskDataTable_statusTable] FOREIGN KEY([taskStatus])
REFERENCES [dbo].[StatusTable] ([statusID])
GO
ALTER TABLE [dbo].[TaskDataTable] CHECK CONSTRAINT [FK_taskDataTable_statusTable]
GO
ALTER TABLE [dbo].[TaskDataTable]  WITH CHECK ADD  CONSTRAINT [FK_taskDataTable_User] FOREIGN KEY([assigneeId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[TaskDataTable] CHECK CONSTRAINT [FK_taskDataTable_User]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([TeamID])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_Teams]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_User] FOREIGN KEY([TeamMemberId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_User]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_User] FOREIGN KEY([TeamLeder])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_Teams_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[upsC_addTeam]    Script Date: 24-08-2022 09:40:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[upsC_addTeam]
	@TeamName as nchar(10),
	@TeamLeder as int,
	@MemberList as AddMembers READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Teams]
           ([TeamName]
           ,[TeamLeder])
     VALUES
           (@TeamName,
           @TeamLeder)

declare @lastId as int = @@IDENTITY;

INSERT INTO [dbo].[TeamMembers]
           ([TeamMemberId]
           ,[TeamId])
select m.userid,@lastId from @MemberList m

END
GO
/****** Object:  StoredProcedure [dbo].[usp_addRole]    Script Date: 24-08-2022 09:40:03 ******/


