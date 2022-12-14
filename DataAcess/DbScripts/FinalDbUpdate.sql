USE [master]
GO
/****** Object:  Database [taskDatabase]    Script Date: 30-08-2022 01:10:03 AM ******/
CREATE DATABASE [taskDatabase]
 GO
ALTER DATABASE [taskDatabase] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [taskDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [taskDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [taskDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [taskDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [taskDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [taskDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [taskDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [taskDatabase] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [taskDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [taskDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [taskDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [taskDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [taskDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [taskDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [taskDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [taskDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [taskDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [taskDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [taskDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [taskDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [taskDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [taskDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [taskDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [taskDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [taskDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [taskDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [taskDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [taskDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [taskDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [taskDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [taskDatabase]
GO
/****** Object:  UserDefinedTableType [dbo].[AddMembers]    Script Date: 30-08-2022 01:10:04 AM ******/
CREATE TYPE [dbo].[AddMembers] AS TABLE(
	[userID] [int] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[AddAction]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAction] 
	-- Add the parameters for the stored procedure here
	@ControllerName as char(25)
    ,@ActionName as char(25)
    ,@ShowInSideBar as bit
    ,@DisplayName as varchar(50),
	@ActionAccess as AddMembers READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Actions]
                           ([ControllerName]
                            ,[ActionName]
                            ,[ShowInSideBar]
                             ,[DisplayName])
                        VALUES
                            (@ControllerName
                            ,@ActionName
                            ,@ShowInSideBar
                             ,@DisplayName)
 declare @lastId as int = @@IDENTITY;
	 INSERT INTO [dbo].[ActionAccess]
           ([RoleId]
           ,[ActionId])
select m.userid,@lastId from @ActionAccess m


END

GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUser]
	-- Add the parameters for the stored procedure here
	 @id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from [user] where id=@id
END


GO
/****** Object:  StoredProcedure [dbo].[GetUserCount]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserCount] 
	-- Add the parameters for the stored procedure here
	@id as int
	 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select * from TaskDataTable where assigneeId=@id
END


GO
/****** Object:  StoredProcedure [dbo].[UnassigneeTask]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UnassigneeTask]
	-- Add the parameters for the stored procedure here
	@id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [TaskDataTable] set assigneeId=null where taskId=@id
END


GO
/****** Object:  StoredProcedure [dbo].[upsC_addTeam]    Script Date: 30-08-2022 01:10:04 AM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_Addtask]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:    <Author,,Name>
-- Create date: <Create Date,,>
-- Description:  <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Addtask] 
 
  @taskName as varchar(50),
  @description as varchar(100),
  @taskStatus as int,
  @assigneeId as int,
  @reporterId as int,  
   @FlagList as AddMembers READONLY,
   @sprintId as int,
    @LableList as AddMembers READONLY
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

    -- Insert statements for procedure here
  INSERT INTO [dbo].[taskDataTable]
                            ([taskName]
                            ,[description]
                            ,[taskStatus]
                             ,[assigneeId],
							 [reporterId],
							  [sprintId])
                        VALUES
                            (@taskName
                            ,@description
                            ,@taskStatus
                             ,@assigneeId,
                             @reporterId,
							  @sprintId)

     declare @lastId as int = @@IDENTITY;

     INSERT INTO [dbo].[FlagList]
           ([taskId],
		   [FlagId]           )
select @lastId,m.userid from @FlagList m

INSERT INTO [dbo].[Task_LableList]
           ([taskId],
		   [LableId]           )
select @lastId,m.userid from @LableList m
END

GO
/****** Object:  StoredProcedure [dbo].[usp_getFilterTaskList]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getFilterTaskList] 
  -- Add the parameters for the stored procedure here
  @UserId AS int,
  @StatusId AS int
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

    -- Insert statements for procedure here
  DECLARE @TeamsCount AS int;
  Select @TeamsCount = count(TeamID) from [dbo].[Teams] where TeamLeder = @UserId
   IF @TeamsCount = 0
   BEGIN 
     Select 
      * From 
     [dbo].[TaskDataTable] 
     where assigneeId = @UserId AND taskStatus =@StatusId
   END
  ELSE
    select 
      * from 
    [dbo].[taskDataTable] 
    where assigneeId IN (select
      distinct us.Id from 
    [dbo].[TeamMembers] as tm 
    join [dbo].[Teams] as t on t.TeamID = tm.TeamId
    join [dbo].[User] as us on tm.TeamMemberId = us.Id or us.Id = t.TeamLeder
    where tm.TeamId in(select TeamId from [dbo].[Teams] where TeamLeder = @UserId)) AND taskStatus = @StatusId
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetMemberList]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Usp_GetMemberList] 
  -- Add the parameters for the stored procedure here
  @TeamId as int

AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

    -- Insert statements for procedure here
  select 
  distinct us.Id,
  us.Username,
  us.FirstName,
  us.LastName,
  t.TeamName,
  t.TeamLeder from 
[dbo].[TeamMembers] as tm 
join [dbo].[Teams] as t on t.TeamID = tm.TeamId
join [dbo].[User] as us on tm.TeamMemberId = us.Id or us.Id = t.TeamLeder
where tm.TeamId = @TeamId
END

GO
/****** Object:  StoredProcedure [dbo].[Usp_TeamListWithLeaderName]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_TeamListWithLeaderName] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
	t.TeamID,
	t.TeamName,
	u.FirstName,
	u.LastName,
	count(tm.TeamMemberId) as MemberCount from [dbo].[TeamMembers] As tm
join [dbo].[Teams] As t on t.TeamID=tm.TeamId 
join [dbo].[User] as u on u.Id = t.TeamLeder
group by t.TeamID,t.TeamName,t.TeamLeder,u.FirstName,u.LastName

END

GO
/****** Object:  StoredProcedure [dbo].[ViewTask]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewTask]
	-- Add the parameters for the stored procedure here
	@id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.taskId,t.taskName,t.taskStatus,t.description,t.assigneeId ,u.Username,s.statusName from TaskDataTable t left join [user] u on
 t.assigneeId=u.Id join StatusTable s on
 s.statusID=t.taskStatus where t.assigneeId=@id
END


GO
/****** Object:  Table [dbo].[ActionAccess]    Script Date: 30-08-2022 01:10:04 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Actions]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Actions](
	[ActionId] [int] IDENTITY(1,1) NOT NULL,
	[ControllerName] [char](25) NULL,
	[ActionName] [char](25) NULL,
	[ShowInSideBar] [bit] NULL,
	[DisplayName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Actions__FFE3F4D9B7DED1C3] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Complexity]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Complexity](
	[ComplexityId] [int] IDENTITY(1,1) NOT NULL,
	[ComplexityName] [nvarchar](20) NULL,
 CONSTRAINT [PK_Complexity] PRIMARY KEY CLUSTERED 
(
	[ComplexityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FlagList]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlagList](
	[taskId] [int] NOT NULL,
	[FlagId] [int] NOT NULL,
 CONSTRAINT [PK_FlagList] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC,
	[FlagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FlagTable]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlagTable](
	[FlagId] [int] IDENTITY(1,1) NOT NULL,
	[FlagName] [nvarchar](50) NULL,
 CONSTRAINT [PK_FlagTable] PRIMARY KEY CLUSTERED 
(
	[FlagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IssueType]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IssueType](
	[IssueId] [int] IDENTITY(1,1) NOT NULL,
	[IssueName] [nvarchar](20) NULL,
 CONSTRAINT [PK_IssuType] PRIMARY KEY CLUSTERED 
(
	[IssueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LableList]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LableList](
	[LableId] [int] IDENTITY(1,1) NOT NULL,
	[LableName] [nvarchar](50) NULL,
 CONSTRAINT [PK_LableList] PRIMARY KEY CLUSTERED 
(
	[LableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Allow User Creation] [bit] NOT NULL,
	[Allow Team Creation] [bit] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SprintTable]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SprintTable](
	[SprintId] [int] IDENTITY(1,1) NOT NULL,
	[SprintName] [nvarchar](20) NULL,
 CONSTRAINT [PK_SprintTable] PRIMARY KEY CLUSTERED 
(
	[SprintId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StatusTable]    Script Date: 30-08-2022 01:10:04 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table1]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table1](
	[complexityId] [int] NOT NULL,
	[TaskName] [nchar](10) NULL,
 CONSTRAINT [PK_Table1] PRIMARY KEY CLUSTERED 
(
	[complexityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task_LableList]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_LableList](
	[taskId] [int] NOT NULL,
	[LableId] [int] NOT NULL,
 CONSTRAINT [PK_Task_LableList] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC,
	[LableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskDataTable]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskDataTable](
	[taskId] [int] IDENTITY(1,1) NOT NULL,
	[taskName] [varchar](50) NULL,
	[taskStatus] [int] NULL,
	[description] [varchar](100) NULL,
	[assigneeId] [int] NULL,
	[reporterId] [int] NULL,
	[SprintId] [int] NULL,
	[IssuId] [int] NULL,
 CONSTRAINT [PK_taskDataTable] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TeamMembers]    Script Date: 30-08-2022 01:10:04 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 30-08-2022 01:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nchar](10) NULL,
	[TeamLeder] [int] NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 30-08-2022 01:10:04 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 10)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 11)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 12)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 13)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (1, 14)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 1)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 4)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 7)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 10)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 11)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (2, 14)
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
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 10)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 11)
GO
INSERT [dbo].[ActionAccess] ([RoleId], [ActionId]) VALUES (3, 14)
GO
SET IDENTITY_INSERT [dbo].[Actions] ON 

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
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (7, N'AddTeam                  ', N'CreateTeam               ', 1, N'Add New Team')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (10, N'Home                     ', N'FlagList                 ', 1, N'View Flag List')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (11, N'Action                   ', N'SetAction                ', 1, N'Go To set Action')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (12, N'Home                     ', N'LableListView            ', 1, N'Add label')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (13, N'Home                     ', N'SprintList               ', 1, N'Add Sprint')
GO
INSERT [dbo].[Actions] ([ActionId], [ControllerName], [ActionName], [ShowInSideBar], [DisplayName]) VALUES (14, N'Home                     ', N'UserManagement           ', 1, N'User Management')
GO
SET IDENTITY_INSERT [dbo].[Actions] OFF
GO
SET IDENTITY_INSERT [dbo].[Complexity] ON 

GO
INSERT [dbo].[Complexity] ([ComplexityId], [ComplexityName]) VALUES (1, N'High')
GO
INSERT [dbo].[Complexity] ([ComplexityId], [ComplexityName]) VALUES (2, N'Mid')
GO
INSERT [dbo].[Complexity] ([ComplexityId], [ComplexityName]) VALUES (3, N'Low')
GO
SET IDENTITY_INSERT [dbo].[Complexity] OFF
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (61, 1)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (61, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (62, 1)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (62, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (63, 1)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (63, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (64, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (65, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (66, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (67, 2)
GO
INSERT [dbo].[FlagList] ([taskId], [FlagId]) VALUES (68, 2)
GO
SET IDENTITY_INSERT [dbo].[FlagTable] ON 

GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (1, N'ganpati')
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (2, N'fvsfvdsvg')
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (3, NULL)
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (4, NULL)
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (5, NULL)
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (6, NULL)
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (7, NULL)
GO
INSERT [dbo].[FlagTable] ([FlagId], [FlagName]) VALUES (9, N'asa')
GO
SET IDENTITY_INSERT [dbo].[FlagTable] OFF
GO
SET IDENTITY_INSERT [dbo].[IssueType] ON 

GO
INSERT [dbo].[IssueType] ([IssueId], [IssueName]) VALUES (1, N'Block by')
GO
INSERT [dbo].[IssueType] ([IssueId], [IssueName]) VALUES (2, N'Duplicate')
GO
INSERT [dbo].[IssueType] ([IssueId], [IssueName]) VALUES (3, N'related to')
GO
SET IDENTITY_INSERT [dbo].[IssueType] OFF
GO
SET IDENTITY_INSERT [dbo].[LableList] ON 

GO
INSERT [dbo].[LableList] ([LableId], [LableName]) VALUES (1, N'test')
GO
INSERT [dbo].[LableList] ([LableId], [LableName]) VALUES (2, N'dummy')
GO
INSERT [dbo].[LableList] ([LableId], [LableName]) VALUES (3, N'done')
GO
INSERT [dbo].[LableList] ([LableId], [LableName]) VALUES (4, N'dre')
GO
INSERT [dbo].[LableList] ([LableId], [LableName]) VALUES (5, N'rty')
GO
SET IDENTITY_INSERT [dbo].[LableList] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

GO
INSERT [dbo].[Role] ([Id], [Name], [Allow User Creation], [Allow Team Creation]) VALUES (1, N'Admin', 1, 1)
GO
INSERT [dbo].[Role] ([Id], [Name], [Allow User Creation], [Allow Team Creation]) VALUES (2, N'HR', 1, 0)
GO
INSERT [dbo].[Role] ([Id], [Name], [Allow User Creation], [Allow Team Creation]) VALUES (3, N'User', 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[SprintTable] ON 

GO
INSERT [dbo].[SprintTable] ([SprintId], [SprintName]) VALUES (1, N'desk')
GO
INSERT [dbo].[SprintTable] ([SprintId], [SprintName]) VALUES (2, N'computer')
GO
SET IDENTITY_INSERT [dbo].[SprintTable] OFF
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (1, N'Todo      ')
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (2, N'Active    ')
GO
INSERT [dbo].[StatusTable] ([statusID], [statusName]) VALUES (3, N'completed ')
GO
INSERT [dbo].[Task_LableList] ([taskId], [LableId]) VALUES (66, 3)
GO
INSERT [dbo].[Task_LableList] ([taskId], [LableId]) VALUES (67, 2)
GO
INSERT [dbo].[Task_LableList] ([taskId], [LableId]) VALUES (68, 3)
GO
SET IDENTITY_INSERT [dbo].[TaskDataTable] ON 

GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (11, N'task-004', 3, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (14, N'task-006', 3, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (15, N'task-001', 3, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (16, N'task-007', 3, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (18, N'task-10', 3, NULL, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (19, N'task-0011', 3, NULL, 3, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (20, N'task-0013', 3, NULL, 8, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (21, N'task-0014', 2, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (22, N'task-0015', 3, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (23, N'task-0015', 2, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (24, N'task-001', 3, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (25, N'read', 1, N'read a book', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (26, N'write', 2, N'write a book', 3, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (27, N'rrrrrrr', 1, N'dmdmdrerfdggsfddADasdSDWDEFEF', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (28, N'rttyty', 2, N'dmdmdjkk;lklkl;ll;l;l;l;oiopioipo', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (29, N'rr', 2, N'hjhk', 3, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (30, N'hhhhhhhhh', 2, N'hhhhhhh', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (31, N'read', 1, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (32, N'read', 3, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (33, N'add record', 1, N'its urgent', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (34, N'update  record', 2, N'abc', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (35, N'vh', 1, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (36, N'read', 2, N'vgghv', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (37, N'read', 3, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (38, N'add', 1, N'add', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (39, N'update', 2, N'update', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (40, N'delete', 3, N'delete', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (41, N'addtask', 1, N'add', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (42, N'activetask', 2, N'active', 7, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (43, N'completetask', 3, N'complate', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (44, N'read book', 2, N'hbnmbmnbn', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (45, N'happy', 1, N'teywty', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (46, N'read', 3, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (47, N'rere', 3, N'dmdmdgggfggfgasdadassaefuuky,mnhn', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (48, N'hii', 1, N'dmdmdgggfggfgasdadassaefuuky,mnhn', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (49, N'mayur', 2, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (50, N'read', 1, N'dmdmdjkk;lklkl;ll;l;l;l;oiopioipo', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (51, N'book', 1, N'dmdmdrerfdggsfddADasdSDWDEFEF', 7, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (52, N'check', 1, N'rahul', 7, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (53, N'hii', 1, N'dmdmdgggfggfgasdadassaefuuky,mnhn', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (54, N'read', 2, N'read a book', 3, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (55, N'rttyty', 3, N'dmdmd', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (56, N'rttyty', 2, N'dmdmdrerfdggsfddADasdSDWDEFEF', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (57, N'test11', 3, N'dmdmdrerfdggsfddADasdSDWDEFEF', 18, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (58, N'task-001', 1, N'this is description', 8, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (59, N'task-001', 1, N'this is description', 8, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (60, N'task-001', 1, N'this is description', 8, NULL, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (61, N'task-002', 1, N'sdgsd', 8, 8, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (62, N'final check', 2, N'this is description', 9, 12, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (63, N'mayur task', 2, N'mayur task', 9, 8, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (64, N'czdczc', 1, N'zsczs', 9, 11, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (65, N'sagar-test', 1, N'ssssssssss', 18, 11, NULL, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (66, N'rttyty', 2, N'dmdmdrerfdggsfddADasdSDWDEFEF', 9, 9, 2, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (67, N'rahul', 3, N'dmdmdrerfdggsfddADasdSDWDEFEF', 9, 18, 2, NULL)
GO
INSERT [dbo].[TaskDataTable] ([taskId], [taskName], [taskStatus], [description], [assigneeId], [reporterId], [SprintId], [IssuId]) VALUES (68, N'read', 2, N'dmdmdgggfggfgasdadassaefuuky,mnhn', 10, 10, 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[TaskDataTable] OFF
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (2, 1)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (2, 2)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (2, 4)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (2, 5)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (2, 7)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (3, 1)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (3, 3)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (7, 3)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (7, 5)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (7, 7)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (8, 2)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (8, 4)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (8, 5)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (8, 7)
GO
INSERT [dbo].[TeamMembers] ([TeamMemberId], [TeamId]) VALUES (9, 4)
GO
SET IDENTITY_INSERT [dbo].[Teams] ON 

GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (1, N'team 1    ', 1)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (2, N'team 2    ', 3)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (3, N'final task', 9)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (4, N'new team  ', 1)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (5, N'final task', 1)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (6, NULL, 1)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (7, N'khklh     ', 9)
GO
INSERT [dbo].[Teams] ([TeamID], [TeamName], [TeamLeder]) VALUES (8, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Teams] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (1, N'Sagar', N'123', 1, N'Sagar', N'Gavand', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (2, N'Wrahul', N'123', 1, N'Rahul', N'Wagh', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (3, N'rahulw', N'123', 1, N'Rahul', N'patil', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (7, N'Sagar', N'123', 1, N'rahul', N'Wagh', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (8, N'mmhatre', N'123', 2, N'mayur', N'mhatre', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (9, N'mmokal', N'123', 3, N'mitesh ', N'mokal', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (10, N'Smhatre', N'123', 2, N'sameer', N'mhatre', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (11, N'spatil', N'123', 3, N'suraj', N'patil', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (12, N'rahul', N'123', 1, N'dev', N'patil', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (18, N'dummy2', N'123', 3, N'test2', N'test2', NULL, NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (19, N'Wrahul', N'123', 2, N'Rahul', N'mhatre', CAST(N'2022-08-30 00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (20, N'test', N'123', 2, N'test-test', N'patil', CAST(N'2022-08-30 00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
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
ALTER TABLE [dbo].[FlagList]  WITH CHECK ADD  CONSTRAINT [FK_FlagList_FlagTable] FOREIGN KEY([FlagId])
REFERENCES [dbo].[FlagTable] ([FlagId])
GO
ALTER TABLE [dbo].[FlagList] CHECK CONSTRAINT [FK_FlagList_FlagTable]
GO
ALTER TABLE [dbo].[FlagList]  WITH CHECK ADD  CONSTRAINT [FK_FlagList_TaskDataTable] FOREIGN KEY([taskId])
REFERENCES [dbo].[TaskDataTable] ([taskId])
GO
ALTER TABLE [dbo].[FlagList] CHECK CONSTRAINT [FK_FlagList_TaskDataTable]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role] FOREIGN KEY([Id])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role]
GO
ALTER TABLE [dbo].[Task_LableList]  WITH CHECK ADD  CONSTRAINT [FK_Task_LableList_LableList] FOREIGN KEY([LableId])
REFERENCES [dbo].[LableList] ([LableId])
GO
ALTER TABLE [dbo].[Task_LableList] CHECK CONSTRAINT [FK_Task_LableList_LableList]
GO
ALTER TABLE [dbo].[Task_LableList]  WITH CHECK ADD  CONSTRAINT [FK_Task_LableList_TaskDataTable] FOREIGN KEY([taskId])
REFERENCES [dbo].[TaskDataTable] ([taskId])
GO
ALTER TABLE [dbo].[Task_LableList] CHECK CONSTRAINT [FK_Task_LableList_TaskDataTable]
GO
ALTER TABLE [dbo].[TaskDataTable]  WITH CHECK ADD  CONSTRAINT [FK_TaskDataTable_IssuType] FOREIGN KEY([IssuId])
REFERENCES [dbo].[IssueType] ([IssueId])
GO
ALTER TABLE [dbo].[TaskDataTable] CHECK CONSTRAINT [FK_TaskDataTable_IssuType]
GO
ALTER TABLE [dbo].[TaskDataTable]  WITH CHECK ADD  CONSTRAINT [FK_TaskDataTable_SprintTable] FOREIGN KEY([SprintId])
REFERENCES [dbo].[SprintTable] ([SprintId])
GO
ALTER TABLE [dbo].[TaskDataTable] CHECK CONSTRAINT [FK_TaskDataTable_SprintTable]
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
ALTER TABLE [dbo].[TaskDataTable]  WITH CHECK ADD  CONSTRAINT [FK_TaskDataTable_User1] FOREIGN KEY([reporterId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[TaskDataTable] CHECK CONSTRAINT [FK_TaskDataTable_User1]
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
USE [master]
GO
ALTER DATABASE [taskDatabase] SET  READ_WRITE 
GO
