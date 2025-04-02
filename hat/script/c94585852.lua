--万魔殿－悪魔の巣窟－
--Pandemonium
function c94585852.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Alter LP cost for "Archfiend" monsters during the Standby Phase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc94585852(c94585852,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EFFECT_LPCOST_REPLACE)
	e2:SetCondition(c94585852.lrcon)
	c:RegisterEffect(e2)
	--Search an "Archfiend" monster
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc94585852(c94585852,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetRange(LOCATION_FZONE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_EVENT_PLAYER)
	e4:SetCode(EVENT_CUSTOM+c94585852)
	e4:SetTarget(c94585852.target)
	e4:SetOperation(c94585852.operation)
	c:RegisterEffect(e4)
	aux.GlobalCheck(s,function()
		--Global effect since either player can use this effect
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c94585852.regop)
		Duel.RegisterEffect(ge1,0)
	end)
end
c94585852.listed_series={0x45}
function c94585852.regfilter(c)
	return c:IsReason(REASON_DESTROY) and not c:IsReason(REASON_BATTLE) and c:IsSetCard(0x45) and c:HasLevel()
		and (c:IsPreviousLocation(LOCATION_MZONE) or (not c:IsPreviousLocation(LOCATION_MZONE) and c:IsMonster()))
end
function c94585852.regop(e,tp,eg,ep,ev,re,r,rp)
	local lv1=0
	local lv2=0
	local g1=Group.CreateGroup()
	local g2=Group.CreateGroup()
	for tc in aux.Next(eg) do
		if c94585852.regfilter(tc) then
			local tlv=tc:GetLevel()
			if tc:IsControler(0) then
				if tlv>lv1 then lv1=tlv end
			else
				if tlv>lv2 then lv2=tlv end
			end
		end
	end
	if lv1>0 then Duel.RaiseEvent(g1,EVENT_CUSTOM+c94585852,re,r,rp,0,lv1) end
	if lv2>0 then Duel.RaiseEvent(g1,EVENT_CUSTOM+c94585852,re,r,rp,1,lv2) end
end
function c94585852.lrcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return Duel.GetCurrentPhase()==PHASE_STANDBY and rc:IsSetCard(0x45) and rc:IsMonster()
end
function c94585852.filter(c,lv)
	return c:GetLevel()<lv and c:IsSetCard(0x45) and c:IsMonster() and c:IsAbleToHand()
end
function c94585852.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94585852.filter,tp,LOCATION_DECK,0,1,nil,ev) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c94585852.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c94585852.filter,tp,LOCATION_DECK,0,1,1,nil,ev)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end