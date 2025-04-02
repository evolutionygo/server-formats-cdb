--Ｅ・ＨＥＲＯ フレイム・ウィングマン (Anime)
--Elemental HERO Flame Wingman (Anime)
function c511018028.initial_effect(c)
	--Fusion Materials
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,21844576,58932615)
	--Must be Fusion Sumoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--Inflict damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511018028(c511018028,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c511018028.damtg)
	e2:SetOperation(c511018028.damop)
	c:RegisterEffect(e2)
end
c511018028.material_setcode={SET_HERO,SET_ELEMENTAL_HERO}
c511018028.listed_series={SET_HERO,SET_ELEMENTAL_HERO}
c511018028.listed_names={21844576,58932615}
function c511018028.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetHandler():GetBattleTarget():GetPreviousAttackOnField()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511018028.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end