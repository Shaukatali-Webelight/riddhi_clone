enum OrderStatus<T extends String> {
  approved('APPROVED'),
  completed('COMPLETED'),
  inProgress('IN PROGRESS'),
  pending('PENDING'),
  rejected('REJECTED'),
  cancel('CANCEL'),
  dispatch('DISPATCH'),
  ordered('ORDERED'),
  approvalAwait('APPROVAL AWAIT'),
  unknown('unknown');

  const OrderStatus(this.value);
  final T value;
}

enum OrderTimelineType<T extends String> {
  regularOrder('REGULAR'),
  returnOrder('RETURN');

  const OrderTimelineType(this.value);
  final T value;
}

enum OrderStatusFilter<T extends String> {
  all('All'),
  approved('APPROVED'),
  pending('PENDING'),
  rejected('REJECTED');

  const OrderStatusFilter(this.value);
  final T value;
}

enum PastOrderStatusFilter<T extends String> {
  all('All'),
  completed('COMPLETED'),
  inProgress('IN_PROGRESS'),
  rejected('REJECTED');

  const PastOrderStatusFilter(this.value);
  final T value;
}

enum FilterStatus<T extends String> {
  all('All'),
  completed('Completed'),
  inProgress('In Progress'),
  approved('Approved'),
  rejected('Rejected'),
  pending('Pending');

  const FilterStatus(this.value);
  final T value;
}

enum TimelineStatus {
  done,
  inProgress,
  failed,
  todo,
  await,
}

enum DeviceVersion {
  android13(13);

  const DeviceVersion(this.value);
  final int value;
}

enum TransportMode<T extends String> {
  twoWheeler('2W', 'bike'),
  fourWheeler('4W', 'car'),
  publicTransport('PUB_TRANS', 'train'),
  withOthers('WITH_OTHERS', 'withOther'),
  home('HOME', 'home');

  const TransportMode(this.value, this.iconName);
  final T value;
  final String iconName;

  String get label {
    switch (this) {
      case TransportMode.twoWheeler:
        return '2W';
      case TransportMode.fourWheeler:
        return '4W';
      case TransportMode.publicTransport:
        return 'Pub. Trans';
      case TransportMode.withOthers:
        return 'With Others';
      case TransportMode.home:
        return 'Home';
    }
  }
}

enum BottomNavBarIndex<T extends int> {
  home(0),
  customer(1),
  startDay(2),
  meetings(3),
  more(4);

  const BottomNavBarIndex(this.value);
  final T value;
}

enum ModuleIDs<T extends int> {
  orderApproval(46),
  sdoAppointment(47),
  sdoTermination(48),
  demoMaterial(117),
  customer(49),
  meetings(50),
  rsp(118);

  const ModuleIDs(this.value);
  final T value;
}

enum PastBottomNavBarIndex<T extends int> {
  pastOrder(0),
  returnOrder(1);

  const PastBottomNavBarIndex(this.value);
  final T value;
}

enum ApprovalBottomNavBarIndex<T extends int> {
  order(0),
  returnOrder(1);

  const ApprovalBottomNavBarIndex(this.value);
  final T value;
}

enum DemoMaterialStatus<T extends String> {
  all('All'),
  allocate('ALLOCATE'),
  received('RECEIVED'),
  notReceived('NOT RECEIVED');

  const DemoMaterialStatus(this.value);
  final T value;
}

enum SDOBottomNavBarIndex<T extends int> {
  sdo(0),
  create(1),
  approval(2);

  const SDOBottomNavBarIndex(this.value);
  final T value;
}

enum SDOTerminationBottomNavBarIndex<T extends int> {
  sdo(0),
  request(1);

  const SDOTerminationBottomNavBarIndex(this.value);
  final T value;
}

enum Permission<T extends String> {
  read('Read'),
  write('Write'),
  delete('Delete'),
  report('Report');

  const Permission(this.value);
  final T value;
}

enum ModuleType<T extends String> {
  mobile('mobile');

  const ModuleType(this.value);
  final T value;
}

enum CustomerFilterType<T extends String> {
  selectedZones('selectedZones'),
  selectedDepots('selectedDepots'),
  selectedRegions('selectedRegions'),
  selectedSubRegions('selectedSubRegions'),
  selectedTerritories('selectedTerritories'),
  selectedSortType('selectedSortType');

  const CustomerFilterType(this.value);
  final T value;
}

enum ProductFocusType<T extends String> {
  nonFocus('Non-Focus'),
  focus('Focus');

  const ProductFocusType(this.value);
  final T value;
}

enum FileExtension<T extends String> {
  NONE('none'),
  //* Image
  JPEG('jpeg'),
  JPG('jpg'),
  PNG('png'),
  HEIF('heif'),
  SVG('svg'),
  //* Document
  BMP('bmp'),
  WEBP('webp'),
  DOCX('docx'),
  DOC('doc'),
  XLSX('xlsx'),
  XLS('xls'),
  PPTX('pptx'),
  PPT('ppt'),
  PDF('pdf'),
  CSV('csv'),
  ODT('odt'),
  ODP('odp'),
  ODS('ods'),
  ZIP('zip'),
  RAR('rar'),
  TAR('tar'),
  GZ('gz'),
  BZ2('bz2'),
  //* Audio
  MP3('mp3'),
  WMA('wma'),
  WAV('wav'),
  OGG('ogg'),
  FLAC('flac'),
  HEVC('hevc'),
  AVI('avi'),
  //* Video
  MP4('mp4'),
  MOV('mov'),
  WMV('wmv'),
  MKV('mkv'),
  FLV('flv');

  const FileExtension(this.value);
  final T value;
}

enum S3Filetype {
  image,
  video,
  document,
  audio,
  none,
  application,
}

enum DemoFilterStatus<T extends String> {
  all('All'),
  completed('Completed'),
  pending('Pending');

  const DemoFilterStatus(this.value);
  final T value;
}

enum DemoMeetingType<T extends String> {
  all('All'),
  demo('Demo'),
  retailer('Retailer'),
  ifm('IFM'),
  reviewMeeting('Review Meeting'),
  ofm('OFM'),
  other('Other');

  const DemoMeetingType(this.value);
  final T value;
}

enum MeetingDayType<T extends String> {
  field('FIELD'),
  observation('OBSERVATION'),
  demo('DEMO');

  const MeetingDayType(this.value);
  final String value;
}

enum MeetingStatus<T extends String> {
  pending('PENDING'),
  completed('COMPLETED');

  const MeetingStatus(this.value);
  final String value;
}

enum CreateMeetingType<T extends String> {
  retailer('RETAILER'),
  ifm('IFM'),
  demo('DEMO'),
  reviewMeeting('REVIEW_MEETING'),
  ofm('OFM'),
  other('OTHER');

  const CreateMeetingType(this.value);
  final T value;
}

enum StockQuantityType<T extends String> {
  allocated('ALLOCATED'),
  spent('SPENT');

  const StockQuantityType(this.value);
  final String value;
}

enum StageOfCrops<T extends String> {
  dafs('DAFS'),
  dat('DAT'),
  daf('DAF'),
  dap('DAP'),
  das('DAS'),
  floweringStage('FLOWERING'),
  preSowing('PRE-SOWING');

  const StageOfCrops(this.value);
  final String value;
}

enum QuantityType<T extends String> {
  gm('GM'),
  ml('ML');

  const QuantityType(this.value);
  final String value;
}

enum Effectiveness<T extends String> {
  excellent('EXCELLENT'),
  good('GOOD'),
  moderate('MODERATE'),
  poor('POOR'),
  notApplicable('Not Applicable');

  const Effectiveness(this.value);
  final String value;
}

enum ExperienceStatus<T extends String> {
  fresher('FRESHER'),
  experience('EXPERIENCED'),
  none('');

  const ExperienceStatus(this.value);
  final T value;
}

enum CreateAppointmentStep<T extends int> {
  BASIC_INFORMATION(0),
  DISTRIBUTION(1),
  BANK_DETAILS(2),
  ADDITIONAL_INFORMATION(3),
  EXPERIENCE_INFORMATION(4),
  DOCUMENTS(5);

  const CreateAppointmentStep(this.value);
  final T value;
}

enum ProductCategory<T extends String> {
  insecticide('Insecticide'),
  fungicide('Fungicide'),
  herbicide('Herbicides'),
  bbnp('BBNP'),
  insefung('Inse + Fung');

  const ProductCategory(this.value);
  final String value;
}

enum ObservationStatusEnum<T extends String> {
  successful('Successful'),
  unsuccessful('Unsuccessful'),
  none('');

  const ObservationStatusEnum(this.value);
  final String value;
}

enum SDOOrderStatus<T extends String> {
  all('All'),
  approved('Approved'),
  rejected('Rejected'),
  pendingForApproval('Pending for approval'),
  pendingAtHO('Pending at HO');

  const SDOOrderStatus(this.value);
  final T value;
}

enum SDOApprovalStatus<T extends String> {
  all('All'),
  approved_by_ho('APPROVED_BY_HO'),
  pending_at_ho('PENDING_AT_HO'),
  rejected_by_ho('REJECTED_BY_HO'),
  approved('APPROVED'),
  rejected('REJECTED'),
  pending('PENDING');

  const SDOApprovalStatus(this.value);
  final T value;
}

enum SDOApprovalReason<T extends String> {
  approved('APPROVED'),
  rejected('REJECTED');

  const SDOApprovalReason(this.value);
  final String value;
}

enum ContinueObservationDay<T extends String> {
  yes('Yes'),
  no('No'),
  none('');

  const ContinueObservationDay(this.value);
  final String value;
}

enum IDType<T extends String> {
  other('Others');

  const IDType(this.value);
  final String value;
}

enum UserType<T extends String> {
  SDO_MDO('SDO/MDO');

  const UserType(this.value);
  final String value;
}

enum TerminationType<T extends String> {
  TERMINATION('TERMINATION'),
  DISCONTINUATION('DISCONTINUATION');

  const TerminationType(this.value);
  final String value;
}

enum HomeModule<T extends int> {
  NONE(0),
  ORDER_APPROVAL(46),
  SDO_APPOINTMENT(47),
  SDO_TERMINATION(48),
  DEMO_MATERIAL(117),
  RSP(118);

  const HomeModule(this.value);
  final int value;
}

enum ExpectedDelivery<T extends String> {
  IMMEDIATE('Immediate'),
  TWO_DAYS('2 Days'),
  FIVE_DAYS('5 Days'),
  FLEXIBLE('Flexible');

  const ExpectedDelivery(this.value);
  final T value;
}

enum OrderType<T extends String> {
  regularOrder('regular_order'), // regular order is also normal order
  superCashOrder('super_cash_order');

  const OrderType(this.value);
  final T value;
}

enum RSPFilterStatus<T extends String> {
  zone('Zone'),
  subRegion('Sub Region'),
  territory('Territory'),
  brand('Brand');

  const RSPFilterStatus(this.value);
  final T value;
}

enum RSPTabType<T extends String> {
  vol('Vol'),
  val('Val');

  const RSPTabType(this.value);
  final T value;
}

enum DemoMeetingTypes<T extends String> {
  customer('CUSTOMER'),
  retailer('RETAILER'),
  ifm('IFM'),
  gfm('GFM'),
  reviewMeeting('REVIEW_MEETING'),
  demo('DEMO'),
  ofm('OFM'),
  mfm('MFM'),
  other('OTHER');

  const DemoMeetingTypes(this.value);
  final T value;
}

enum NotificationType<T extends String> {
  newMaterialAllocation('NEW_MATERIAL_ALLOCATED'),
  sdoAppointmentRequestApproved('SDO_APPOINTMENT_REQUEST_APPROVED'),
  sdoAppointmentRequestRejected('SDO_APPOINTMENT_REQUEST_REJECTED'),
  sdoTerminationRequestApproved('SDO_TERMINATION_REQUEST_APPROVED'),
  sdoTerminationRequestRejected('SDO_TERMINATION_REQUEST_REJECTED'),
  materialTransfer('MATERIAL_TRANSFER'),
  demoMeetingScheduled('DEMO_MEETING_SCHEDULED'),
  demoMeetingReminder('DEMO_MEETING_REMINDER'),
  observationDayReminder('OBSERVATION_DAY_REMINDER'),
  fieldDayReminder('FIELD_DAY_REMINDER'),
  materialReceived('MATERIAL_RECEIVED'),
  materialNotReceived('MATERIAL_NOT_RECEIVED');

  const NotificationType(this.value);
  final T value;
}

enum RoleType<T extends String> {
  tm('TM'),
  am('AM'),
  zm('ZM'),
  gm('GM'),
  agm('AGM'),
  dgm('DGM'),
  vp('VP');

  const RoleType(this.value);
  final T value;
}

enum DownloadType<T extends String> {
  brand('BRAND'),
  brandSku('BRAND SKU');

  const DownloadType(this.value);
  final T value;
}

enum RSPScreenType<T extends String> {
  rspScreen('Rsp Screen'),
  rspSubRegionScreen('Rsp Sub Region Screen'),
  rspTerritoryScreen('Rsp Territory Screen'),
  rspZoneScreen('Rsp Zone Screen');

  const RSPScreenType(this.value);
  final T value;
}

enum InvoiceYear<T extends String> {
  currentYear('Current Year'),
  previousYear('Previous Year');

  const InvoiceYear(this.value);
  final T value;
}

enum ReturnOrderReason<T extends String> {
  damageInTransit('Damaged in transit'),
  godownReturn('Godown return'),
  leakedAndDamagedMaterial('Leakage & damaged material'),
  nearExpireAndExpireMaterial('Near expire & expire material'),
  otherReason('Other reason'),
  partyClosed('Party closed'),
  partyToPartyTransfer('Party to party transfer'),
  placementProduct('Placement product'),
  poorQuality('Poor quality');

  const ReturnOrderReason(this.value);
  final T value;
}
