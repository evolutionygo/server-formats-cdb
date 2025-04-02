--コードブレイカー・ウイルスソードマン
--Codebreaker Virus Swordsman (Anime)
--Scripted by Larry126
local s,c511600272,alias=GetID()
function c511600272.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	c:EnableReviveLimit()
	Link.AddProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x13c),2,2)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600272(168917,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,c511600272)
	e1:SetCondition(c511600272.condition)
	e1:SetTarget(c511600272.target)
	e1:SetOperation(c511600272.operation)
	c:RegisterEffect(e1)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600272(60349525,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1,c511600272-1)
	e2:SetCondition(c511600272.damcon)
	e2:SetTarget(c511600272.damtg)
	e2:SetOperation(c511600272.damop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c511600272.regop)
	c:RegisterEffect(e3)
end
c511600272.listed_series={0x13c}
function c511600272.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c511600272.spfilter(c,e,tp,zones)
	return c:IsLevelBelow(4) and c:IsSetCard(0x13c)
		and (zones[0]>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,0,zones[0])
		or zones[1]>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,1,zones[1]))
end
function c511600272.spfilter2(c,e,tp,sump,zone)
	return c:IsLevelBelow(4) and c:IsSetCard(0x13c)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,sump,zone)
end
function c511600272.filter(c,e,tp)
	if not c:IsLinkMonster() then return false end
	local zones={}
	zones[0]=c:GetLinkedZone(0)&0x1f
	zones[1]=c:GetLinkedZone(1)&0x1f
	return Duel.IsExistingMatchingCard(c511600272.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,zones)
end
function c511600272.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511600272.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511600272.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511600272.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c511600272.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local zones={}
	zones[0]=tc:GetLinkedZone(0)&0x1f
	zones[1]=tc:GetLinkedZone(1)&0x1f
	local ft0=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zones[tp])
	local ft1=Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zones[1-tp])
	if ft0<=0 and ft1<=0 then return end
	local sump=nil
	if ft0<=0 or (ft0>0 and ft1>0 and Duel.SelectYesNo(tp,aux.Stringc511600272(61665245,2))) then
		sump=1-tp
	else
		sump=tp
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511600272.spfilter2),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,sump,zones[sump])
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,sump,false,false,POS_FACEUP_DEFENSE,zones[sump])
	end
end
function c511600272.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c511600272.damfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x13c)
end
function c511600272.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511600272.damfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511600272.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-Duel.GetMatchingGroupCount(c511600272.damfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*500)
		tc:RegisterEffect(e1)
		local dam=atk-tc:GetAttack()
		if not tc:IsImmuneToEffect(e1) and not tc:IsHasEffect(EFFECT_REVERSE_UPDATE) and dam>0 then
			Duel.Damage(1-tp,dam,REASON_EFFECT)
		end
	end
end
function c511600272.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:GetReasonPlayer()~=tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511600272(80250185,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,{c511600272,1})
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c511600272.sptg)
		e1:SetOperation(c511600272.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511600272.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511600272.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end