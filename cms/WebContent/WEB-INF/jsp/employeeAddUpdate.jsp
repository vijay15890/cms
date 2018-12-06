<!DOCTYPE html>
<%@page import="com.application.util.PageUtil"%>
<%@page import="java.util.Random"%>
<%@page import="com.cms.finance.bean.FinancePartyBankBranchDetailsDO"%>
<%@page import="com.cms.finance.dao.FinancePartyBankBranchDetailsDAO"%>
<%@page import="com.cms.finance.dao.FinancePartyBankDetailsDAO"%>
<%@page import="com.cms.finance.bean.FinancePartyBankDetailsDO"%>
<%@page import="com.cms.employee.handler.EmployeeCreationHandler"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.application.util.AppUtil"%>
<%@page import="com.cms.finance.bean.FinancePartyContactDetailsDO"%>
<%@page import="com.cms.finance.bean.FinancePartyAddressDetailsDO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cms.finance.bean.FinanceLedgerMasterDO"%>
<%@page import="com.cms.finance.bean.FinancePartyPersonalDetailsDO"%>
<%@page import="com.cms.employee.bean.AdmEmployeeMasterDO"%>
<html class="loading" lang="en" data-textdirection="ltr">
 <%
  AdmEmployeeMasterDO employeeDO=(AdmEmployeeMasterDO)request.getAttribute("employeeDO");
 if(employeeDO==null){ employeeDO=new  AdmEmployeeMasterDO(); }
 
 FinanceLedgerMasterDO ledgerMstDO=employeeDO.getLedgerMstDO();
 if(ledgerMstDO==null){ ledgerMstDO=new FinanceLedgerMasterDO(); }
 
 FinancePartyPersonalDetailsDO personalDO= employeeDO.getPersonalDO();
 if(personalDO==null){ personalDO=new FinancePartyPersonalDetailsDO(); }
 
 FinancePartyContactDetailsDO contactDO=employeeDO.getContactDO();
 if(contactDO==null){ contactDO=new FinancePartyContactDetailsDO(); }
  
 ArrayList<FinancePartyAddressDetailsDO> addressList=employeeDO.getAddressList();
 if(addressList==null){ addressList=new ArrayList<FinancePartyAddressDetailsDO>(); }
 
 FinancePartyAddressDetailsDO permAddress=null;
 FinancePartyAddressDetailsDO commAddress=null;
 for(FinancePartyAddressDetailsDO addressDO : addressList){
	 if( addressDO.getAddressTypeId()==15 ){ permAddress= addressDO; }
	 if( addressDO.getAddressTypeId()==16 ){ commAddress= addressDO; }
 }
 
 if(permAddress==null){ permAddress=new FinancePartyAddressDetailsDO(); }
 if(commAddress==null){ commAddress=new FinancePartyAddressDetailsDO(); }
 
 employeeDO.getBankBranchId();
 
 FinancePartyBankBranchDetailsDO branchDO=FinancePartyBankBranchDetailsDAO.getFinancePartyBankBranchDetailsByBranchId(null, employeeDO.getBankBranchId(), false);
 if(branchDO==null){ branchDO=new FinancePartyBankBranchDetailsDO(); }

int bankId=branchDO.getBankId();
 
 Map<String, String> bloodgroupMap=new HashMap<String, String>();
 bloodgroupMap.put("none", "None");
 bloodgroupMap.put("a+", "A+");
 bloodgroupMap.put("a-", "A-");
 bloodgroupMap.put("b+", "B+");
 bloodgroupMap.put("b-", "B-");
 bloodgroupMap.put("o+", "O+");
 bloodgroupMap.put("o-", "O-");
 bloodgroupMap.put("ab+", "AB+");
 bloodgroupMap.put("ab-", "AB-");
 
 Map<String, String> genderMap=new HashMap<String, String>();
 genderMap.put("25", "Male");
 genderMap.put("26", "Female");
 genderMap.put("27", "Trans Gender");
 
 Map<String, String> martialMap=new HashMap<String, String>();
 martialMap.put("single", "Single");
 martialMap.put("married", "Married");
 
 String formName="Emp_frm_"+Math.abs( new Random().nextInt(9999) );
 
 %>
 
 <style>
 
 .wizard > .actions {
    display: none;
    }
 </style>
 <div class="modal-dialog modal-lg">
	<div class="modal-content">
			
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel16">Employee Creation</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%=PageUtil.getAlert(request) %>
				
				<form class="tab-wizard wizard-circle"  action="employee?action=save" method="post" id="<%=formName%>">
					<input type="hidden" name="action" value="save">
					<input type="hidden" name="employeeId" value="<%=employeeDO.getEmpId()%>">
					<input type="hidden" name="ledgerId" value="<%=employeeDO.getLedgerId()%>"> 
						<h6>Personal Info</h6>
                                    <section>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="firstName1">First Name :</label>
                                                    <input type="text" class="form-control" id="firstName1"> </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="lastName1">Last Name :</label>
                                                    <input type="text" class="form-control" id="lastName1"> </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="emailAddress1">Email Address :</label>
                                                    <input type="email" class="form-control" id="emailAddress1"> </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="phoneNumber1">Phone Number :</label>
                                                    <input type="tel" class="form-control" id="phoneNumber1"> </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="location1">Select City :</label>
                                                    <select class="custom-select form-control" id="location1" name="location">
                                                        <option value="">Select City</option>
                                                        <option value="Amsterdam">India</option>
                                                        <option value="Berlin">USA</option>
                                                        <option value="Frankfurt">Dubai</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="date1">Date of Birth :</label>
                                                    <input type="date" class="form-control" id="date1"> </div>
                                            </div>
                                        </div>
                                    </section>
                                    <!-- Step 2 -->
                                    <h6>Office Details</h6>
                                    <section>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="jobTitle1">Job Title :</label>
                                                    <input type="text" class="form-control" id="jobTitle1"> </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="videoUrl1">Company Name :</label>
                                                    <input type="text" class="form-control" id="videoUrl1">
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="shortDescription1">Job Description :</label>
                                                    <textarea name="shortDescription" id="shortDescription1" rows="6" class="form-control"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                    <!-- Step 3 -->
                                    <h6>Permanent Address</h6>
                                    <section>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="int1">Interview For :</label>
                                                    <input type="text" class="form-control" id="int1"> </div>
                                                <div class="form-group">
                                                    <label for="intType1">Interview Type :</label>
                                                    <select class="custom-select form-control" id="intType1" data-placeholder="Type to search cities" name="intType1">
                                                        <option value="Banquet">Normal</option>
                                                        <option value="Fund Raiser">Difficult</option>
                                                        <option value="Dinner Party">Hard</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="Location1">Location :</label>
                                                    <select class="custom-select form-control" id="Location1" name="location">
                                                        <option value="">Select City</option>
                                                        <option value="India">India</option>
                                                        <option value="USA">USA</option>
                                                        <option value="Dubai">Dubai</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="jobTitle2">Interview Date :</label>
                                                    <input type="date" class="form-control" id="jobTitle2">
                                                </div>
                                                <div class="form-group">
                                                    <label>Requirements :</label>
                                                    <div class="c-inputs-stacked">
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio6" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio6">Employee</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio7" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio7">Contract</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                    <!-- Step 4 -->
                                    <h6>Communication Address</h6>
                                    <section>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="behName1">Behaviour :</label>
                                                    <input type="text" class="form-control" id="behName1">
                                                </div>
                                                <div class="form-group">
                                                    <label for="participants1">Confidance</label>
                                                    <input type="text" class="form-control" id="participants1">
                                                </div>
                                                <div class="form-group">
                                                    <label for="participants1">Result</label>
                                                    <select class="custom-select form-control" id="participants1" name="location">
                                                        <option value="">Select Result</option>
                                                        <option value="Selected">Selected</option>
                                                        <option value="Rejected">Rejected</option>
                                                        <option value="Call Second-time">Call Second-time</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="decisions1">Comments</label>
                                                    <textarea name="decisions" id="decisions1" rows="4" class="form-control"></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label>Rate Interviwer :</label>
                                                    <div class="c-inputs-stacked">
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio1" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio1">1 star</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio2" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio2">2 star</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio3" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio3">3 star</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio4" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio4">4 star</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadio5" name="customRadio" class="custom-control-input">
                                                            <label class="custom-control-label" for="customRadio5">5 star</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
								</form>
				
				<%-- <div class="form-body">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput1">First Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput1" class="form-control" placeholder="First Name" name="firstName" value="<%=personalDO.getFirstName()%>" required="required">
									<div class="form-control-position">
										<i class="ft-user"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Middle Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Middle Name" name="middleName" value="<%=personalDO.getMiddleName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Last Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Last Name" name="lastName" value="<%=personalDO.getLastName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput1">Father's Name</label>
								<div class="position-relative has-icon-left">
									<input type="hidden" id="timesheetinput1" class="form-control" placeholder="First Name" name="relationTypeId" value="22" required="required">
									<input type="text" id="timesheetinput1" class="form-control" placeholder="Father's Name" name="fatherName" value="<%=personalDO.getFirstNameRel()%>">
									<div class="form-control-position">
										<i class="ft-user"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Email</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Email" name="email" value="<%=contactDO.getEmail1()%>" required="required">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Mobile</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Mobile" name="mobile" value="<%=contactDO.getMobile1()%>" required="required">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Date of Birth</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Date of Birth" name="dob" value="<%=personalDO.getDob()%>" required="required">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<% int gender=personalDO.getGender()==0?25:personalDO.getGender();  %>
						
						
							<div class="col-md-4">
								<div class="form-group">
									<label for="timesheetinput2">Gender</label>
									<div class="position-relative has-icon-left">
										<select id="timesheetinput2" class="form-control" placeholder="Gender" name="gender" required="required">
											<%=AppUtil.formOption( genderMap, ""+gender ) %>
										</select>
										<div class="form-control-position">
											<!-- <i class="la la-briefcase"></i> -->
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="form-group">
									<label for="timesheetinput2">Martial Status</label>
									<div class="position-relative has-icon-left">
										<select id="timesheetinput2" class="form-control" placeholder="Gender" name="martialStatus" required="required">
											<%=AppUtil.formOption( martialMap, ""+personalDO.getMaritalStatus() ) %>
										</select>
										<div class="form-control-position">
											<!-- <i class="la la-briefcase"></i> -->
										</div>
									</div>
								</div>
							</div>
						
					</div>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Blood Group</label>
								<div class="position-relative has-icon-left">
									<select id="timesheetinput2" class="form-control" placeholder="Date of Birth" name="bloodGroup" ">
										<%=AppUtil.formOption(bloodgroupMap, personalDO.getBloodGroup()) %>
									</select>
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
					</div>
					
					 <hr><h4 class="card-title">Office Details</h4>
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Reporting To</label>
								<select id="reportingTo" class="form-control" placeholder="Reporting To" name="reportingTo" required="required">
									<option></option>
									<%=EmployeeCreationHandler.formEmployeeOption(""+employeeDO.getReportingTo(), ""+employeeDO.getEmpId()) %>
								</select>
								<div class="form-control-position">
									<!-- <i class="la la-briefcase"></i> -->
								</div>
								
								<div class="position-relative has-icon-left">
									<input type="text" id="reportingTo" class="form-control" placeholder="Reporting To" name="reportingTo" value="<%=employeeDO.getReportingTo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
								<div class="form-group">
									<label for="timesheetinput2">Department</label>
									<div class="position-relative has-icon-left">
										<select id="timesheetinput2" class="form-control" placeholder="Department" name="department" required="required">
											<option></option>
											<%=EmployeeCreationHandler.formDepartmentOption( ""+employeeDO.getDepartmentId() )%>
										</select>
										<div class="form-control-position">
											<!-- <i class="la la-briefcase"></i> -->
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="timesheetinput2">Designation</label>
									<div class="position-relative has-icon-left">
										<select id="timesheetinput2" class="form-control" placeholder="Designation" name="designation" required="required">
											<option></option>
											<%=EmployeeCreationHandler.formDesignationOption( ""+employeeDO.getDesignationId())%>
										</select>
										<div class="form-control-position">
											<!-- <i class="la la-briefcase"></i> -->
										</div>
									</div>
								</div>
							</div>
					</div>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">ESI.No</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="ESI.No" name="esiNo" value="<%=employeeDO.getEsiNo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">EPF.No</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="EPF.No" name="epfNo" value="<%=employeeDO.getEpfNo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="bankName">Bank Name</label>
								<div class="position-relative has-icon-left">
									<select id="bankName" class="form-control" placeholder="Bank Name" name="bankName">
										<option></option>
										<%
										Map<String, String> bankMap=FinancePartyBankDetailsDAO.loadBankMap(null); if(bankMap==null){ bankMap=new HashMap<String, String>();  }
										%>
										<%=AppUtil.formOption(bankMap, ""+branchDO.getBankId())%>
									</select>
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="branchName">Branch Name</label>
								<div class="position-relative has-icon-left">
									<select id="branchName" class="form-control" placeholder="Branch Name" name="branchName">
										<option></option>
										<%
										Map<String, String> branchMap=FinancePartyBankBranchDetailsDAO.loadBranchMap(null, ""+branchDO.getBankId() ); if(bankMap==null){ bankMap=new HashMap<String, String>();  }
										%>
										<%=AppUtil.formOption(branchMap, ""+branchDO.getBranchId())%>
									</select>
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">A/C.No</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="A/C.No" name="bankAccountNo" value="<%=employeeDO.getBankAccountNo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
					 <hr><h4 class="card-title">Permanent Address</h4>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Door No</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Door No" name="per_doorNo" value="<%=permAddress.getDooNo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Street Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Street Name" name="per_streetName" value="<%=permAddress.getStreetName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Road Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Road Name" name="per_roadName" value="<%=permAddress.getRoadName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Land Mark</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Land Mark" name="per_landMark" value="<%=permAddress.getLandMark()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">City</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="City" name="per_city" value="<%=permAddress.getCity()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">State</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="State" name="per_state" value="<%=permAddress.getState()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					<div class="row">
					
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">PIN Code</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="PIN Code" name="per_pinCode" value="<%=permAddress.getPincode()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
				 	<hr><h4 class="card-title">Communication Address</h4>
					
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Door No</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Door No" name="cmm_doorNo" value="<%=permAddress.getDooNo()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Street Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Street Name" name="cmm_streetName" value="<%=permAddress.getStreetName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Road Name</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Road Name" name="cmm_roadName" value="<%=permAddress.getRoadName()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
					
					<div class="row">
						
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Land Mark</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="Land Mark" name="cmm_landMark" value="<%=permAddress.getLandMark()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">City</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="City" name="cmm_city" value="<%=permAddress.getCity()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">State</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="State" name="cmm_state" value="<%=permAddress.getState()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					<div class="row">
					
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">PIN Code</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="timesheetinput2" class="form-control" placeholder="PIN Code" name="cmm_pinCode" value="<%=permAddress.getPincode()%>">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div> --%>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" data-dismiss="modal">Cancel</button>
				<%-- <button type="button" class="btn grey btn-secondary" onclick="<%=formName %>reset()">Reset</button> --%>
				<button type="submit" class="btn btn-success">Save</button>
			</div>
	</div>
</div>
 
 <%
String qualificationForm="qual_frm_"+Math.abs( new Random().nextInt(9999));
if(employeeDO.getEmpId()!=0 && false){ %>
<section class="row">
    <div class="col-md-12 col-sm-12">
        <div id="with-header" class="card">
            <div class="card-header">
                <h4 class="card-title">Qualification</h4>
                <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="collapse" id="<%=qualificationForm%>_expand"><i class="ft-plus"></i></a></li>
                       <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                       <li><a data-action="close"><i class="ft-x"></i></a></li>
                   </ul>
               </div>
           </div>
           <div class="card-content collapse">
               <div class="card-body border-top-blue-grey border-top-lighten-5 ">
               	<form class="form" action="employee" method="post" id="<%=qualificationForm%>">
               		<input type="hidden" name="action" value="qualification_save">
               		<input type="hidden" name="employeeId" value="">
               		<input type="hidden" name="employeeQualificationId" value="">
                	<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Course</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="course" class="form-control" placeholder="Course" name="course" value="">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Major</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="major" class="form-control" placeholder="PIN Code" name="major" value="">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Grade</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="grade" class="form-control" placeholder="Grade" name="grade" value="">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						
					</div>
                	<div class="row">
                		<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">Year of Completion</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="yearOfCompletion" class="form-control" placeholder="Year of Completion" name="yearOfCompletion" value="">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="timesheetinput2">School/ College/ University</label>
								<div class="position-relative has-icon-left">
									<input type="text" id="instuition" class="form-control" placeholder="Grade" name="instuition" value="">
									<div class="form-control-position">
										<!-- <i class="la la-briefcase"></i> -->
										</div>
									</div>
								</div>
							</div>
							
						</div>
	                	<div class="form-actions right">
							<button type="submit" class="btn btn-primary"> <i class="fa fa-check-square-o"></i> Save</button>
							<button type="button" class="btn btn-danger mr-1"><i class="ft-x"></i> Reset</button>
						</div>
					</form>
                	<div class="table-responsive">
						<table class="table">
							<thead class="bg-primary white">
								<tr>
									<th>#</th>
									<th>Course</th>
									<th>Major</th>
									<th>Grade/Per</th>
									<th>Passed Out</th>
									<th>Institution</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
							
								<tr>
									<th scope="row">1</th>
									<td>aaaa</td>
									<td>bbb</td>
									<td>ccc</td>
									<td>ddd</td>
									<td>ffff</td>
									<td>
										<a id="qualification_edit">Edit</a> &nbsp;&nbsp;
										<a id="qualification_delete">Delete</a></td>
								</tr>
								
							</tbody>
						</table>
					</div> 
                </div>
            </div>
        </div>
    </div>
</section>

<%} %>
 
 
<script type="text/javascript">
$(document).ready(function(){
	
	$(".tab-wizard").steps({
	    headerTag: "h6",
	    bodyTag: "section",
	    transitionEffect: "fade",
	    titleTemplate: '<span class="step">#index#</span> #title#',
	    labels: {
	        finish: "Submit"
	    },
	    onFinished: function(event, currentIndex) {
	        swal("Form Submitted!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.");

	    }
	});
	
	$('#<%=formName%>').on('change', '#bankName', function(){
		var bankId=$(this).val();
		if(bankId!=null && bankId!=''){
			$('#<%=formName%> #branchName').html('<option></option>');
			$.getJSON('employee?action=loadBranch&bankId='+bankId, function(data){
				$('#<%=formName%> #branchName').append(data.option);
			})
		}
		
	});
	
	$('#<%=qualificationForm%>_expand').click( function(){
		
	});
	
	$('#<%=formName%>').submit(function(e){
		var frm=$(this);
		$.ajax({
		 	   url:$(frm).attr('action'),
		 	   data:$(frm).serialize(),
		 	   beforeSend:function(){
		 		  $('#CMS-POPUP-MODEL').html('<center> <img alt="" src="./resource/img/loader.gif"></center>');
		 	   },
		 	   success:function(data){
		 		   $('#CMS-POPUP-MODEL').html(data);
		 	   }
		    }); 
		e.preventDefault();
	});
	
});

</script>

</html>