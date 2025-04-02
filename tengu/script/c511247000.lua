--常闇の契約書 (Anime)
--Dark Contract with the Eternal Darkness (Anime)
function c511247000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
	--Spell/Traps cannot be activated that target a monster(s)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(function(e) return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,c511247000),e:GetHandlerPlayer(),0,LOCATION_SZONE,1,nil) end)
	e2:SetValue(c511247000.evalue)
	c:RegisterEffect(e2)
	--Monsters cannot be Tributed for a Tribute Summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(function(e) return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,c511247000),e:GetHandlerPlayer(),0,LOCATION_SZONE,1,nil) end)
	e3:SetValue(c511247000.sumlimit)
	c:RegisterEffect(e3)
	--Monsters cannot be material for a Fusion, Synchro, or Xyz Summon
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_MATERIAL)
	e4:SetValue(aux.AND(c511247000.matlimit,aux.cannotmatfilter(SUMMON_TYPE_FUSION,SUMMON_TYPE_SYNCHRO,SUMMON_TYPE_XYZ)))
	c:RegisterEffect(e4)
	--Take 1000 damage during your Standby Phase
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc511247000(c511247000,0))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(function(e,tp) return Duel.GetTurnPlayer()==tp end)
	e5:SetTarget(c511247000.damtg)
	e5:SetOperation(c511247000.damop)
	c:RegisterEffect(e5)
end
c511247000.listed_names={c511247000}
function c511247000.evalue(e,re,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=e:GetHandlerPlayer()
end
function c511247000.matlimit(e,c,sumtype,tp)
	if tp==PLAYER_NONE then tp=c:GetControler() end
	return e:GetHandlerPlayer()==1-tp
end
function c511247000.sumlimit(e,c)
	if not c then return false end
	return not c:IsControler(e:GetHandlerPlayer())
end
function c511247000.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c511247000.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end