--万魔殿－悪魔の巣窟－ (Action Field)
--Pandemonium (Action Field)
function c151000033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cost change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc151000033(c151000033,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EFFECT_LPCOST_REPLACE)
	e2:SetCondition(c151000033.lrcon)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetDescription(aux.Stringc151000033(c151000033,1))
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c151000033.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc151000033(c151000033,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_CUSTOM+c151000033)
	e4:SetTarget(c151000033.target)
	e4:SetOperation(c151000033.operation)
	c:RegisterEffect(e4)
end
c151000033.af="a"
c151000033.listed_series={0x45}
function c151000033.lrcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return Duel.GetCurrentPhase()==PHASE_STANDBY and rc:IsSetCard(0x45) and rc:IsMonster()
end
function c151000033.regop(e,tp,eg,ep,ev,re,r,rp)
	if not eg then return end
	local lv1=0
	local lv2=0
	local tc=eg:GetFirst()
	for tc in aux.Next(eg) do
		if tc:IsReason(REASON_DESTROY) and not tc:IsReason(REASON_BATTLE) and tc:IsSetCard(0x45) then
			local tlv=tc:GetLevel()
			if tc:IsControler(0) then
				if tlv>lv1 then lv1=tlv end
			else
				if tlv>lv2 then lv2=tlv end
			end
		end
	end
	if lv1>0 then Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+c151000033,e,0,0,0,lv1) end
	if lv2>0 then Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+c151000033,e,0,1,1,lv2) end
end
function c151000033.filter(c,lv)
	return c:GetLevel()<lv and c:IsSetCard(0x45) and c:IsMonster() and c:IsAbleToHand()
end
function c151000033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c151000033.filter,tp,LOCATION_DECK,0,1,nil,ev) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c151000033.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c151000033.filter,tp,LOCATION_DECK,0,1,1,nil,ev)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end