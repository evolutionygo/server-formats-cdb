--ゴーストリック・マミー
--Ghostrick Mummy
function c97584500.initial_effect(c)
	--Cannot be Normal Summoned, unless you control a "Ghostrick" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(function(e) return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_GHOSTRICK),e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil) end)
	c:RegisterEffect(e1)
	--Change this card to face-down Defense Position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc97584500(c97584500,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c97584500.postg)
	e2:SetOperation(c97584500.posop)
	c:RegisterEffect(e2)
	--Can Normal Summon 1 "Ghostrick" monster in addition to your Normal Summon/Set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc97584500(c97584500,1))
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_HAND|LOCATION_MZONE,0)
	e3:SetTarget(function(_,c) return c:IsSetCard(SET_GHOSTRICK) end)
	c:RegisterEffect(e3)
	--Cannot Special Summon non-DARK monsters
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,0)
	e4:SetTarget(function(_,c) return c:IsAttributeExcept(ATTRIBUTE_DARK) end)
	c:RegisterEffect(e4)
end
c97584500.listed_series={SET_GHOSTRICK}
function c97584500.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(c97584500)==0 end
	c:RegisterFlagEffect(c97584500,RESET_EVENT|(RESETS_STANDARD&~RESET_TURN_SET)|RESET_PHASE|PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c97584500.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end