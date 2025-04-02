--リミット・コード
--Limit Code
--scripted by Larry126
local s,c511600023,alias=GetID()
function c511600023.initial_effect(c)
	c:EnableCounterPermit(0x47)
	alias=c:GetOriginalCodeRule()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_COUNTER+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(aux.RemainFieldCost)
	e1:SetTarget(c511600023.target)
	e1:SetOperation(c511600023.activate)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511600023.desop)
	c:RegisterEffect(e2)
	--remove counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c511600023.rccon)
	e3:SetOperation(c511600023.rcop)
	c:RegisterEffect(e3)
	--Cannot activate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_ONFIELD)
	e4:SetTargetRange(1,0)
	e4:SetValue(c511600023.aclimit)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetRange(LOCATION_GRAVE)
	c:RegisterEffect(e5)
end
c511600023.listed_series={0x101}
function c511600023.aclimit(e,re,tp)
	return re:GetHandler():IsCode(alias) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and not re:GetHandler():IsImmuneToEffect(e)
end
function c511600023.spfilter(c,e,tp)
	return c:IsSetCard(0x101) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c511600023.cfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsLinkMonster()
end
function c511600023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanAddCounter(tp,0x47,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c511600023.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c511600023.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c511600023.cfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,ct,0,0x47)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511600023.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c511600023.cfilter,tp,LOCATION_GRAVE,0,nil)
	if c:IsRelateToEffect(e) and ct>0 and c:IsCanAddCounter(0x47,ct) then
		c:AddCounter(0x47,ct)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c511600023.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
		local equip=true
		if tc then
			Duel.BreakEffect()
			if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
				equip=false
				Duel.Equip(tp,c,tc)
				--Add Equip limit
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_EQUIP_LIMIT)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				e1:SetValue(c511600023.eqlimit)
				e1:SetLabelObject(tc)
				c:RegisterEffect(e1)
				Duel.SpecialSummonComplete()
			end
		end
		if equip and not c:IsStatus(STATUS_LEAVE_CONFIRMED) then
			c:CancelToGrave(false)
		end
	end
end
function c511600023.eqlimit(e,c)
	return e:GetLabelObject()==c
end
function c511600023.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511600023.rccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511600023.rcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsCanRemoveCounter(tp,0x47,1,REASON_EFFECT) then
		c:RemoveCounter(tp,0x47,1,REASON_EFFECT)
		if c:GetCounter(0x47)>0 then return end
		if c:GetEquipTarget() then
			Duel.Destroy(c:GetEquipTarget(),REASON_EFFECT)
		end
	end
end